package com.coach.diet.dto;

public record AddMealItemRequest(
        String foodName,
        Integer quantity,
        String unit,
        Integer calories
) {}
