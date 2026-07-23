package com.coach.member.dto;

import jakarta.validation.constraints.NotBlank;

public record RecommendationDecisionRequest(
        String suggestedAction,
        @NotBlank String coachDecisionNotes
) {
}
