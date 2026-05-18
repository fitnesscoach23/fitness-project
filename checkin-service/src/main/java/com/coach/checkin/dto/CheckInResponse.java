package com.coach.checkin.dto;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public record CheckInResponse(
        UUID id,
        UUID memberId,
        LocalDate checkInDate,
        BigDecimal weight,
        Integer compliance,
        Integer energy,
        String notes,
        Instant createdAt,
        List<MeasurementResponse> measurements
) {
    public record MeasurementResponse(
            String name,
            BigDecimal value
    ){}
}
