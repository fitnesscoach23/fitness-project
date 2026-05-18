package com.coach.diet.dto;

import java.util.UUID;

public record CreateDietPlanRequest(
        UUID memberId,
        String title,
        String notes
) {}
