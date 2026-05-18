package com.coach.diet.dto;

import java.util.List;
import java.util.UUID;

public record SaveDietPlanRequest(
        UUID memberId,
        String title,
        String notes,
        List<DietRowDto> rows
) {}

