package com.coach.checkin.simple.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

public record CreateProgressCheckInRequest(
    UUID memberId,
    BigDecimal weight,
    Integer dietAdherence,
    Integer energy,
    @Min(1) @Max(10) Integer exerciseRating,
    Integer stepsAvg,
    String notes,
    Instant submittedAt
) {}
