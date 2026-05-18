package com.coach.billing.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

public record CreatePaymentRequest(
        UUID memberId,
        BigDecimal amount,
        LocalDate paymentDate,
        String mode,
        String notes
) {}
