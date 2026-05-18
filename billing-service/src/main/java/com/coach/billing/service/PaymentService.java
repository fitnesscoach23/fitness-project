package com.coach.billing.service;

import com.coach.billing.dto.CreatePaymentRequest;
import com.coach.billing.dto.StartPaymentResponse;
import com.coach.billing.entity.Payment;
import com.coach.billing.entity.PaymentStatus;
import com.coach.billing.exception.PaymentNotFoundException;
import com.coach.billing.repository.PaymentRepository;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import lombok.RequiredArgsConstructor;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final PaymentRepository repo;
    private final SubscriptionService subscriptionService;
    private final RazorpayClientService razorpayClientService;

    @Value("${razorpay.key-id}")
    private String razorpayKeyId;

    public UUID record(String coachEmail, CreatePaymentRequest req) {
        Payment p = Payment.builder()
                .memberId(req.memberId())
                .coachEmail(coachEmail)
                .amount(req.amount())
                .paymentDate(req.paymentDate())
                .mode(req.mode())
                .notes(req.notes())
                .createdAt(Instant.now())
                .build();

        repo.save(p);
        return p.getId();
    }

    public List<Payment> list(String coachEmail, UUID memberId) {
        return repo.findByMemberIdAndDeletedAtIsNullOrderByPaymentDateDesc(memberId)
                .stream()
                .filter(p -> p.getCoachEmail().equals(coachEmail))
                .toList();
    }

    public UUID startPayment(String coachEmail, UUID memberId, BigDecimal amount) {
        Payment p = Payment.builder()
                .memberId(memberId)
                .coachEmail(coachEmail)
                .amount(amount)
                .mode("MANUAL")
                .gateway("MANUAL")
                .status(PaymentStatus.PENDING)
                .createdAt(Instant.now())
                .build();

        repo.save(p);
        return p.getId();
    }

    public void confirmPayment(UUID paymentId, LocalDate paymentDate) {
        Payment p = findActivePayment(paymentId);
        LocalDate effectivePaymentDate = paymentDate != null ? paymentDate : LocalDate.now();

        p.setStatus(PaymentStatus.SUCCESS);
        p.setPaymentDate(effectivePaymentDate);
        repo.save(p);

        // Activate subscription for 1 month
        subscriptionService.activateOrExtendSubscription(
                p.getCoachEmail(),
                p.getMemberId(),
                effectivePaymentDate,
                effectivePaymentDate.plusMonths(1)
        );
    }

    public void failPayment(UUID paymentId) {
        Payment p = findActivePayment(paymentId);

        p.setStatus(PaymentStatus.FAILED);
        repo.save(p);
    }

    public List<Payment> history(UUID memberId) {
        return repo.findByMemberIdAndDeletedAtIsNullOrderByCreatedAtDesc(memberId);
    }

    public void deletePayment(String coachEmail, UUID paymentId) {
        Payment payment = repo.findByIdAndCoachEmailAndDeletedAtIsNull(paymentId, coachEmail)
                .orElseThrow(() -> new PaymentNotFoundException(paymentId));
        boolean shouldRecalculateSubscription = payment.getStatus() == PaymentStatus.SUCCESS;

        payment.setDeletedAt(Instant.now());
        repo.save(payment);

        if (shouldRecalculateSubscription) {
            resetSubscriptionAfterPaymentDelete(payment);
        }
    }

    private void resetSubscriptionAfterPaymentDelete(Payment deletedPayment) {
        LocalDate fallbackEndDate = repo
                .findByMemberIdAndCoachEmailAndStatusAndDeletedAtIsNullOrderByPaymentDateDesc(
                        deletedPayment.getMemberId(),
                        deletedPayment.getCoachEmail(),
                        PaymentStatus.SUCCESS
                )
                .stream()
                .map(Payment::getPaymentDate)
                .filter(date -> date != null)
                .findFirst()
                .map(date -> date.plusMonths(1))
                .orElse(null);

        subscriptionService.resetLatestSubscriptionAfterPaymentDelete(
                deletedPayment.getCoachEmail(),
                deletedPayment.getMemberId(),
                fallbackEndDate
        );
    }

    public StartPaymentResponse startOnlinePayment(
            String coachEmail,
            UUID memberId,
            BigDecimal amount
    ) throws Exception {

        // 1. Create internal payment first
        Payment payment = Payment.builder()
                .memberId(memberId)
                .coachEmail(coachEmail)
                .amount(amount)
                .mode("ONLINE")
                .gateway("RAZORPAY")
                .status(PaymentStatus.PENDING)
                .createdAt(Instant.now())
                .build();

        repo.save(payment);

        // 2. Create Razorpay order
        long amountInPaise = amount.multiply(BigDecimal.valueOf(100)).longValue();

        RazorpayClient client = razorpayClientService.getClient();

        JSONObject options = new JSONObject();
        options.put("amount", amountInPaise);
        options.put("currency", "INR");
        options.put("receipt", payment.getId().toString());

        Order order = client.orders.create(options);

        // 3. Update payment with gateway order id
        payment.setGatewayOrderId(order.get("id"));
        repo.save(payment);

        // 4. Return checkout payload
        return new StartPaymentResponse(
                payment.getId().toString(),
                "RAZORPAY",
                razorpayKeyId,
                order.get("id"),
                amountInPaise,
                "INR"
        );
    }

    public void processWebhookEvent(byte[] payload) {

        JSONObject event = new JSONObject(new String(payload));
        String eventType = event.getString("event");

        JSONObject paymentEntity = event
                .getJSONObject("payload")
                .getJSONObject("payment")
                .getJSONObject("entity");

        String razorpayOrderId = paymentEntity.optString("order_id");
        String razorpayPaymentId = paymentEntity.optString("id");

        switch (eventType) {

            case "payment.captured" -> handlePaymentCaptured(
                    razorpayOrderId,
                    razorpayPaymentId
            );

            case "payment.failed" -> handlePaymentFailed(
                    razorpayOrderId
            );

            default -> {
                // Ignore other events for now
            }
        }
    }

    private void handlePaymentCaptured(
            String gatewayOrderId,
            String gatewayPaymentId
    ) {
        Payment payment = repo.findByGatewayOrderIdAndDeletedAtIsNull(gatewayOrderId)
                .orElseThrow(() -> new IllegalStateException(
                        "Payment not found for order " + gatewayOrderId
                ));

        // Idempotency check
        if (payment.getStatus() == PaymentStatus.SUCCESS) {
            return;
        }

        payment.setStatus(PaymentStatus.SUCCESS);
        payment.setGatewayPaymentId(gatewayPaymentId);
        payment.setPaymentDate(LocalDate.now());

        repo.save(payment);

        // Activate subscription
        subscriptionService.activateOrExtendSubscription(
                payment.getCoachEmail(),
                payment.getMemberId(),
                LocalDate.now(),
                LocalDate.now().plusMonths(1)
        );
    }

    private void handlePaymentFailed(String gatewayOrderId) {
        repo.findByGatewayOrderIdAndDeletedAtIsNull(gatewayOrderId).ifPresent(payment -> {
            payment.setStatus(PaymentStatus.FAILED);
            repo.save(payment);
        });
    }

    private Payment findActivePayment(UUID paymentId) {
        return repo.findByIdAndDeletedAtIsNull(paymentId)
                .orElseThrow(() -> new PaymentNotFoundException(paymentId));
    }

}
