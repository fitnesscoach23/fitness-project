package com.coach.billing.util;

import com.coach.billing.service.RazorpayClientService;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class RazorpayStartupCheck {

    private final RazorpayClientService razorpayClientService;

    @PostConstruct
    public void verify() {
        try {
            razorpayClientService.getClient();
            System.out.println("✅ Razorpay client initialized successfully");
        } catch (Exception e) {
            throw new RuntimeException("❌ Razorpay client init failed", e);
        }
    }
}
