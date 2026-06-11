package com.coach.workout.dto;

import jakarta.validation.constraints.Min;

public record UpdateWorkoutPlanRequest(
        String title,
        String notes,
        @Min(0) Integer targetStepsCount
) {}
