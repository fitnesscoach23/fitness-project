package com.coach.member.dto;

import com.coach.member.entity.CoachingPhaseStatus;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

public record CoachingPhaseRequest(
        Integer phaseNumber,
        @NotBlank String phaseName,
        String goal,
        @NotNull LocalDate startDate,
        LocalDate plannedEndDate,
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
        @NotBlank String coachReason
) {
}
