package com.coach.diet_review.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record DietReviewRowDto(
        @NotBlank(message = "mealType is required")
        String mealType,

        @NotBlank(message = "foodName is required")
        String foodName,

        @NotNull(message = "quantity is required")
        @Min(value = 0, message = "quantity must be zero or greater")
        Integer quantity,

        @NotBlank(message = "unit is required")
        String unit,

        @NotNull(message = "protein is required")
        @Min(value = 0, message = "protein must be zero or greater")
        Integer protein,

        @NotNull(message = "carbs is required")
        @Min(value = 0, message = "carbs must be zero or greater")
        Integer carbs,

        @NotNull(message = "fat is required")
        @Min(value = 0, message = "fat must be zero or greater")
        Integer fat,

        @NotNull(message = "calories is required")
        @Min(value = 0, message = "calories must be zero or greater")
        Integer calories
) {
}
