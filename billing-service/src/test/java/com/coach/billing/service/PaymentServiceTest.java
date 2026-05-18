package com.coach.billing.service;

import com.coach.billing.entity.Payment;
import com.coach.billing.entity.PaymentStatus;
import com.coach.billing.exception.PaymentNotFoundException;
import com.coach.billing.repository.PaymentRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class PaymentServiceTest {

    @Mock
    private PaymentRepository paymentRepository;

    @Mock
    private SubscriptionService subscriptionService;

    @Mock
    private RazorpayClientService razorpayClientService;

    @InjectMocks
    private PaymentService paymentService;

    @Test
    void deletePaymentSoftDeletesMatchingPayment() {
        UUID paymentId = UUID.randomUUID();
        Payment payment = Payment.builder()
                .id(paymentId)
                .memberId(UUID.randomUUID())
                .coachEmail("coach@example.com")
                .amount(BigDecimal.TEN)
                .mode("MANUAL")
                .gateway("MANUAL")
                .createdAt(Instant.now())
                .build();

        when(paymentRepository.findByIdAndCoachEmailAndDeletedAtIsNull(paymentId, "coach@example.com"))
                .thenReturn(Optional.of(payment));

        paymentService.deletePayment("coach@example.com", paymentId);

        ArgumentCaptor<Payment> captor = ArgumentCaptor.forClass(Payment.class);
        verify(paymentRepository).save(captor.capture());
        assertNotNull(captor.getValue().getDeletedAt());
    }

    @Test
    void deleteSuccessfulPaymentResetsSubscriptionFromRemainingSuccessfulPayment() {
        UUID paymentId = UUID.randomUUID();
        UUID memberId = UUID.randomUUID();
        Payment deletedPayment = Payment.builder()
                .id(paymentId)
                .memberId(memberId)
                .coachEmail("coach@example.com")
                .amount(BigDecimal.TEN)
                .mode("MANUAL")
                .gateway("MANUAL")
                .status(PaymentStatus.SUCCESS)
                .paymentDate(LocalDate.of(2026, 5, 10))
                .createdAt(Instant.now())
                .build();
        Payment previousPayment = Payment.builder()
                .id(UUID.randomUUID())
                .memberId(memberId)
                .coachEmail("coach@example.com")
                .amount(BigDecimal.TEN)
                .mode("MANUAL")
                .gateway("MANUAL")
                .status(PaymentStatus.SUCCESS)
                .paymentDate(LocalDate.of(2026, 4, 10))
                .createdAt(Instant.now())
                .build();

        when(paymentRepository.findByIdAndCoachEmailAndDeletedAtIsNull(paymentId, "coach@example.com"))
                .thenReturn(Optional.of(deletedPayment));
        when(paymentRepository.findByMemberIdAndCoachEmailAndStatusAndDeletedAtIsNullOrderByPaymentDateDesc(
                memberId,
                "coach@example.com",
                PaymentStatus.SUCCESS
        )).thenReturn(List.of(previousPayment));

        paymentService.deletePayment("coach@example.com", paymentId);

        verify(subscriptionService).resetLatestSubscriptionAfterPaymentDelete(
                "coach@example.com",
                memberId,
                LocalDate.of(2026, 5, 10)
        );
    }

    @Test
    void deletePaymentThrowsWhenMissing() {
        UUID paymentId = UUID.randomUUID();
        when(paymentRepository.findByIdAndCoachEmailAndDeletedAtIsNull(paymentId, "coach@example.com"))
                .thenReturn(Optional.empty());

        assertThrows(PaymentNotFoundException.class,
                () -> paymentService.deletePayment("coach@example.com", paymentId));
    }

    @Test
    void historyExcludesDeletedPayments() {
        UUID memberId = UUID.randomUUID();
        List<Payment> payments = List.of(
                Payment.builder().id(UUID.randomUUID()).createdAt(Instant.now()).build()
        );

        when(paymentRepository.findByMemberIdAndDeletedAtIsNullOrderByCreatedAtDesc(memberId))
                .thenReturn(payments);

        assertEquals(payments, paymentService.history(memberId));
    }
}
