package com.coach.billing.service;

import com.razorpay.RazorpayClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class RazorpayClientService {

    private final RazorpayClient client;

    public RazorpayClientService(
            @Value("${razorpay.key-id}") String keyId,
            @Value("${razorpay.key-secret}") String keySecret
    ) throws Exception {
        this.client = new RazorpayClient(keyId, keySecret);
    }

    public RazorpayClient getClient() {
        return client;
    }
}
