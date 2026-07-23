package com.coach.member.dto;

import com.coach.member.entity.ProgressPlannerChangeSource;
import com.coach.member.entity.ProgressPlannerChangeType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;
import java.util.UUID;

public record ProgressPlannerChangeRequest(
        UUID phaseId,
        @NotNull ProgressPlannerChangeType changeType,
        LocalDate changeDate,
        String previousValue,
        String newValue,
        @NotBlank String reason,
        String coachNotes,
        ProgressPlannerChangeSource source
) {
}
