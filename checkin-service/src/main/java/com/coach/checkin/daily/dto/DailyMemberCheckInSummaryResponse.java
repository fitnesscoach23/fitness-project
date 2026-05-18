package com.coach.checkin.daily.dto;

public record DailyMemberCheckInSummaryResponse(
        int daysInMonth,
        int recordedDays,
        int activeDays,
        int exerciseDays,
        int totalSteps
) {
}
