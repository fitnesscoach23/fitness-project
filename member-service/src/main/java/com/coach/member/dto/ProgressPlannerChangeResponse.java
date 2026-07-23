package com.coach.member.dto;

import com.coach.member.entity.ProgressPlannerChangeSource;
import com.coach.member.entity.ProgressPlannerChangeType;

import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

public record ProgressPlannerChangeResponse(
        UUID id,
        UUID memberId,
        UUID phaseId,
        ProgressPlannerChangeType changeType,
        LocalDate changeDate,
        String previousValue,
        String newValue,
        String reason,
        String coachNotes,
        ProgressPlannerChangeSource source,
        String createdBy,
        Instant createdAt
) {
}
