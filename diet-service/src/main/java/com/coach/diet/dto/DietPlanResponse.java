package com.coach.diet.dto;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record DietPlanResponse(
        UUID id,
        UUID memberId,
        String title,
        String notes,
        Instant createdAt,
        List<Meal> meals
) {

    public record Meal(
            UUID id,
            String mealName,
            Integer orderIndex,
            List<MealItem> items
    ) {}

    public record MealItem(
            UUID id,
            String foodName,
            Integer quantity,
            String unit,
            Integer protein,
            Integer carbs,
            Integer fat,
            Integer calories
    ) {}
}
