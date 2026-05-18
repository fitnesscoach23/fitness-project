package com.coach.billing.controller;

import com.coach.billing.service.PaymentService;
import com.razorpay.Utils;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.StandardCharsets;

@RestController
@RequestMapping("/billing/webhook")
@RequiredArgsConstructor
public class RazorpayWebhookController {

    private final PaymentService paymentService;

    @Value("${webhook.secret}")
    private String webhookSecret;

    @PostMapping
    public ResponseEntity<String> handleWebhook(
            HttpServletRequest request,
            @RequestBody byte[] payload
    ) {
        try {
            String signature = request.getHeader("X-Razorpay-Signature");

            // 1. Verify signature FIRST
            Utils.verifyWebhookSignature(
                    new String(payload, StandardCharsets.UTF_8),
                    signature,
                    webhookSecret
            );

            // 2. Delegate processing
            paymentService.processWebhookEvent(payload);

            return ResponseEntity.ok("OK");

        } catch (Exception e) {
            return ResponseEntity.status(400).body("Webhook verification failed");
        }
    }
}
