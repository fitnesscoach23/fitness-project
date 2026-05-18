package com.coach.billing.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class StartPaymentResponse {
    private String paymentId;
    private String gateway;
    private String razorpayKeyId;
    private String razorpayOrderId;
    private Long amount;      // in paise
    private String currency;
}
