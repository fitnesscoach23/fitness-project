package com.coach.checkin.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public record UpdateCheckInRequest(
        LocalDate checkInDate,
        BigDecimal weight,
        Integer compliance,
        Integer energy,
        String notes,
        List<MeasurementRequest> measurements
) {
    public record MeasurementRequest(
            String name,
            BigDecimal value
    ) {}
}
