package com.coach.diet_review.service;

import com.coach.diet_review.dto.RowSuggestionDto;

import java.util.List;

public record GeneratedDietReview(
        String summary,
        List<String> suggestions,
        List<RowSuggestionDto> rowSuggestions
) {
}
