package com.coach.checkin.simple.dto;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

public record ProgressCheckInResponse(
    UUID id,
    UUID memberId,
    BigDecimal weight,
    Integer dietAdherence,
    Integer energy,
    Integer exerciseRating,
    Integer stepsAvg,
    String notes,
    Instant submittedAt
) {}
