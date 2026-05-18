package com.coach.diet.dto;

import com.coach.diet.entity.FoodCategory;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;

public record UpsertFoodLibraryItemRequest(
        @NotBlank(message = "foodItem is required")
        String foodItem,

        @NotNull(message = "calories is required")
        @DecimalMin(value = "0.0", message = "calories must be >= 0")
        BigDecimal calories,

        @NotNull(message = "carbs is required")
        @DecimalMin(value = "0.0", message = "carbs must be >= 0")
        BigDecimal carbs,

        @NotNull(message = "protein is required")
        @DecimalMin(value = "0.0", message = "protein must be >= 0")
        BigDecimal protein,

        @NotNull(message = "fats is required")
        @DecimalMin(value = "0.0", message = "fats must be >= 0")
        BigDecimal fats,

        @NotNull(message = "category is required")
        FoodCategory category
) {
}
