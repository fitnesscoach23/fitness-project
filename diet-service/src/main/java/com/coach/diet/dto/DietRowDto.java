package com.coach.diet.dto;

public record DietRowDto(
        String mealType,
        String foodName,
        Integer quantity,
        String unit,
        Integer protein,
        Integer carbs,
        Integer fat,
        Integer calories
) {}
