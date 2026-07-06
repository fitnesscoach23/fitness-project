package com.coach.checkin.daily.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;

import java.time.LocalDate;
import java.util.UUID;

public record UpsertDailyMemberCheckInRequest(
        @NotNull UUID memberId,
        @NotNull LocalDate checkInDate,
        Boolean exerciseDone,
        @PositiveOrZero Integer stepsCount,
        Boolean stepTargetAchieved,
        Boolean travelWorkout,
        Boolean recoveryDay,
        Boolean activeOther,
        Boolean workoutVideoNotShared,
        Boolean stepsRecordNotShared,
        Boolean notActive,
        String notes
) {
}
