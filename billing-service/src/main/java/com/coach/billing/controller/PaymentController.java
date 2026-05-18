package com.coach.billing.controller;


import com.coach.billing.dto.ConfirmPaymentRequest;
import com.coach.billing.dto.CreatePaymentRequest;
import com.coach.billing.service.PaymentService;
import com.coach.billing.util.CurrentUserUtil;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.UUID;

@RestController
@RequestMapping("/billing/payment")
@RequiredArgsConstructor
public class PaymentController {

    private final PaymentService service;
    private final CurrentUserUtil current;

    @PostMapping
    public ResponseEntity<?> create(@RequestBody CreatePaymentRequest req) {
        UUID id = service.record(current.coachEmail(), req);
        return ResponseEntity.ok(id);
    }

    @GetMapping("/{memberId}")
    public ResponseEntity<?> list(@PathVariable UUID memberId) {
        return ResponseEntity.ok(service.list(current.coachEmail(), memberId));
    }

    @PostMapping("/start/{memberId}")
    public ResponseEntity<?> start(
            @PathVariable UUID memberId,
            @RequestParam BigDecimal amount,
            @RequestParam(defaultValue = "MANUAL") String mode
    ) throws Exception {

        if ("ONLINE".equalsIgnoreCase(mode)) {
            return ResponseEntity.ok(
                    service.startOnlinePayment(
                            current.coachEmail(),
                            memberId,
                            amount
                    )
            );
        }

        // default MANUAL (Phase-1 behaviour)
        UUID id = service.startPayment(
                current.coachEmail(),
                memberId,
                amount
        );
        return ResponseEntity.ok(id);
    }


    @PostMapping("/confirm/{paymentId}")
    public ResponseEntity<?> confirm(
            @PathVariable UUID paymentId,
            @RequestBody(required = false) ConfirmPaymentRequest req
    ) {
        service.confirmPayment(paymentId, req == null ? null : req.paymentDate());
        return ResponseEntity.ok("Payment Confirmed");
    }

    @PostMapping("/fail/{paymentId}")
    public ResponseEntity<?> fail(@PathVariable UUID paymentId) {
        service.failPayment(paymentId);
        return ResponseEntity.ok("Payment Failed");
    }

    @GetMapping("/history/{memberId}")
    public ResponseEntity<?> history(@PathVariable UUID memberId) {
        return ResponseEntity.ok(service.history(memberId));
    }

    @DeleteMapping("/{paymentId}")
    @Operation(summary = "Delete a payment history entry")
    public ResponseEntity<String> delete(@PathVariable UUID paymentId) {
        service.deletePayment(current.coachEmail(), paymentId);
        return ResponseEntity.ok("Payment deleted successfully");
    }
}
