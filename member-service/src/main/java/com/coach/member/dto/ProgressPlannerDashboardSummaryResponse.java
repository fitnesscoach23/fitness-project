package com.coach.member.dto;

public record ProgressPlannerDashboardSummaryResponse(
        long membersDueForPhaseReview,
        long workoutChangeRecommended,
        long dietAdjustmentRecommended,
        long stepChangeRecommended,
        long deloadRecoveryReviewRequired,
        long noChangeRequired,
        long overduePhaseReviews
) {
}
