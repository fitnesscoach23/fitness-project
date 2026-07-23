package com.coach.member.dto;

import com.coach.member.entity.CoachingPhaseStatus;

import java.time.LocalDate;
import java.util.UUID;

public record ProgressPlannerWorkQueueRow(
        UUID memberId,
        String memberName,
        String currentGoal,
        UUID phaseId,
        String currentPhase,
        long weekInPhase,
        String latestConsistencyScore,
        LocalDate latestCheckInDate,
        String recommendationType,
        String priority,
        LocalDate reviewDueDate,
        CoachingPhaseStatus status,
        boolean overdue
) {
}
