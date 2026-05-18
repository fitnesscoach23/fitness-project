package com.coach.checkin.daily.dto;

import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

public record DailyMemberCheckInDayResponse(
        UUID id,
        LocalDate checkInDate,
        boolean exerciseDone,
        Integer stepsCount,
        boolean active,
        String notes,
        Instant createdAt,
        Instant updatedAt
) {
}
