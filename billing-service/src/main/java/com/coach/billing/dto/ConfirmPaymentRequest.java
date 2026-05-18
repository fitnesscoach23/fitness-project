package com.coach.billing.dto;

import java.time.LocalDate;

public record ConfirmPaymentRequest(
        LocalDate paymentDate
) {}
