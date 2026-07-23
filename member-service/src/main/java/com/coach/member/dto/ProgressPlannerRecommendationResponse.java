package com.coach.member.dto;

import com.coach.member.entity.ProgressRecommendationPriority;
import com.coach.member.entity.ProgressRecommendationStatus;
import com.coach.member.entity.ProgressRecommendationType;

import java.time.Instant;
import java.util.UUID;

public record ProgressPlannerRecommendationResponse(
        UUID id,
        UUID memberId,
        UUID phaseId,
        ProgressRecommendationType recommendationType,
        String title,
        String suggestedAction,
        String reason,
        String supportingMetrics,
        ProgressRecommendationPriority priority,
        ProgressRecommendationStatus status,
        Instant generatedAt,
        Instant reviewedAt,
        String coachDecisionNotes
) {
}
