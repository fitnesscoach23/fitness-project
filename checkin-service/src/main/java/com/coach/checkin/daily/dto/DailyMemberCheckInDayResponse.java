package com.coach.checkin.daily.dto;

import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

public record DailyMemberCheckInDayResponse(
        UUID id,
        LocalDate checkInDate,
        boolean exerciseDone,
        Integer stepsCount,
        boolean stepTargetAchieved,
        boolean travelWorkout,
        boolean recoveryDay,
        boolean activeOther,
        boolean workoutVideoNotShared,
        boolean stepsRecordNotShared,
        boolean notActive,
        boolean active,
        String notes,
        Instant createdAt,
        Instant updatedAt
) {
}
