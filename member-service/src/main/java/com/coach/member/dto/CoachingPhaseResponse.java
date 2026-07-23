package com.coach.member.dto;

import com.coach.member.entity.CoachingPhaseStatus;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

public record CoachingPhaseResponse(
        UUID id,
        UUID memberId,
        Integer phaseNumber,
        String phaseName,
        String goal,
        LocalDate startDate,
        LocalDate plannedEndDate,
        LocalDate actualEndDate,
        CoachingPhaseStatus status,
        UUID workoutPlanId,
        UUID dietPlanId,
        Integer calorieTarget,
        BigDecimal proteinTarget,
        BigDecimal carbTarget,
        BigDecimal fatTarget,
        Integer stepTarget,
        Integer plannedWorkoutDays,
        String phaseNotes,
        String coachReason,
        long currentDay,
        long currentWeek,
        boolean reviewOverdue,
        Instant createdAt,
        Instant updatedAt
) {
}
