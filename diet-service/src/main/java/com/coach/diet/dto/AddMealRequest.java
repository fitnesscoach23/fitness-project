package com.coach.diet.dto;

public record AddMealRequest(
        String mealName,
        Integer orderIndex
) {}
