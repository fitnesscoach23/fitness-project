package com.coach.diet_review.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

import java.util.List;

public record DietReviewRequest(
        @NotBlank(message = "memberId is required")
        String memberId,

        @Valid
        @NotNull(message = "targetTotals is required")
        DietMacroTotalsDto targetTotals,

        @Valid
        @NotNull(message = "currentTotals is required")
        DietMacroTotalsDto currentTotals,

        @NotEmpty(message = "rows are required")
        List<@Valid DietReviewRowDto> rows
) {
}
