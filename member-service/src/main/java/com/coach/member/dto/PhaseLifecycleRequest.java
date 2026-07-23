package com.coach.member.dto;

import jakarta.validation.constraints.NotBlank;

import java.time.LocalDate;

public record PhaseLifecycleRequest(
        LocalDate actionDate,
        @NotBlank String reason,
        String coachNotes
) {
}
