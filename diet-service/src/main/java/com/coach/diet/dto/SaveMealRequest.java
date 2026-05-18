// SaveMealRequest.java
package com.coach.diet.dto;

import java.util.List;
import java.util.UUID;

public record SaveMealRequest(
        String mealName,
        Integer orderIndex,
        List<MealItemDto> items
) {
    public record MealItemDto(
            UUID id,
            String foodName,
            Integer quantity,
            String unit,
            int calories
    ) {}
}
