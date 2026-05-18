package com.coach.diet.entity;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

import java.util.Locale;

public enum FoodCategory {
    CARBOHYDRATES,
    PROTEINS,
    FATS;

    @JsonCreator
    public static FoodCategory fromValue(String value) {
        if (value == null) {
            return null;
        }

        String normalized = value.trim().toUpperCase(Locale.ROOT);

        return switch (normalized) {
            case "CARBOHYDRATES", "CARBS" -> CARBOHYDRATES;
            case "PROTEINS", "PROTEIN" -> PROTEINS;
            case "FATS", "FAT" -> FATS;
            default -> throw new IllegalArgumentException("Invalid category: " + value);
        };
    }

    @JsonValue
    public String toValue() {
        return name();
    }
}
