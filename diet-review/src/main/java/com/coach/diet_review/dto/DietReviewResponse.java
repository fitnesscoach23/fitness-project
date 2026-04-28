package com.coach.diet_review.dto;

import java.util.List;

public record DietReviewResponse(
        String memberId,
        String summary,
        List<MacroGapDto> macroGaps,
        List<String> suggestions,
        List<RowSuggestionDto> rowSuggestions,
        String disclaimer,
        String reviewSource
) {
}
