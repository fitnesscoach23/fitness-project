package com.coach.diet_review.dto;

public record MacroGapDto(
        String metric,
        Integer target,
        Integer current,
        Integer difference,
        String status
) {
}
