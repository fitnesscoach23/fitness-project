package com.coach.diet.dto;

import com.coach.diet.entity.FoodCategory;

import java.math.BigDecimal;
import java.util.UUID;

public record FoodLibraryItemResponse(
        UUID id,
        String foodItem,
        BigDecimal calories,
        BigDecimal carbs,
        BigDecimal protein,
        BigDecimal fats,
        FoodCategory category
) {
}
