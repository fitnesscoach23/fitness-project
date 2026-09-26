package com.coach.checkin.simple.dto;

import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

public record CreateProgressCheckInRequest(
    UUID memberId,
    BigDecimal weight,
    Integer dietAdherence,
    Integer energy,
    @DecimalMin("1.0") @DecimalMax("10.0") @Digits(integer = 2, fraction = 1) BigDecimal exerciseRating,
    Integer stepsAvg,
    String notes,
    Instant submittedAt
) {}
