package com.coach.member.dto;

import java.util.List;

public record ProgressPlannerOverviewResponse(
        CoachingPhaseResponse currentPhase,
        List<CoachingPhaseResponse> phases,
        List<ProgressPlannerChangeResponse> timeline,
        List<ProgressPlannerRecommendationResponse> recommendations
) {
}
