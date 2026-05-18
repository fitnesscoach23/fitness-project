package com.coach.diet.dto;

public record UpdateMealRequest(
        String mealName,
        Integer orderIndex
) {}
