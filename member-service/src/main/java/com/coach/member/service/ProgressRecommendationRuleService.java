package com.coach.member.service;

import com.coach.member.entity.*;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

@Service
public class ProgressRecommendationRuleService {

    public List<ProgressPlannerRecommendation> generate(Member member, CoachingPhase phase) {
        List<ProgressPlannerRecommendation> recommendations = new ArrayList<>();
        if (phase == null) {
            return recommendations;
        }

        long week = Math.max(1, (ChronoUnit.DAYS.between(phase.getStartDate(), LocalDate.now()) / 7) + 1);
        boolean overdue = phase.getPlannedEndDate() != null && phase.getPlannedEndDate().isBefore(LocalDate.now());
        String goal = firstText(phase.getGoal(), member.getMainTrainingGoal(), member.getGoal(), "Not set");

        if (overdue) {
            recommendations.add(build(
                    member,
                    phase,
                    ProgressRecommendationType.PHASE_REVIEW,
                    "Phase review overdue",
                    "Review the current phase with the coach before changing plans.",
                    "The planned review date has passed. Review progress, consistency, recovery, and adherence before deciding whether to continue, modify, or complete this phase.",
                    "Current week: %s; planned review date: %s; goal: %s".formatted(week, phase.getPlannedEndDate(), goal),
                    ProgressRecommendationPriority.HIGH,
                    "PHASE_UPDATED"
            ));
        } else if (week >= 4) {
            recommendations.add(build(
                    member,
                    phase,
                    ProgressRecommendationType.PHASE_REVIEW,
                    "Review phase soon",
                    "Review this phase and decide whether to continue unchanged or plan the next phase.",
                    "This phase has enough time under it to justify a coach review, but time alone is not a reason to change the member's plan.",
                    "Current week: %s; planned review date: %s; goal: %s".formatted(week, phase.getPlannedEndDate(), goal),
                    ProgressRecommendationPriority.MEDIUM,
                    "PHASE_UPDATED"
            ));
        }

        if (week >= 4 && phase.getPlannedWorkoutDays() != null) {
            recommendations.add(build(
                    member,
                    phase,
                    ProgressRecommendationType.WORKOUT,
                    "Workout review recommended",
                    "Check workout fit, compliance, performance trend, and recovery before making changes.",
                    "The phase has been running long enough for a structured workout review. Do not change exercises unless compliance, performance, pain, boredom, or recovery data supports it.",
                    "Current week: %s; planned workout days: %s".formatted(week, phase.getPlannedWorkoutDays()),
                    ProgressRecommendationPriority.MEDIUM,
                    "WORKOUT_PLAN"
            ));
        }

        if (phase.getCalorieTarget() == null || phase.getProteinTarget() == null) {
            recommendations.add(build(
                    member,
                    phase,
                    ProgressRecommendationType.DIET,
                    "Diet targets need review",
                    "Confirm calories and macros for this phase.",
                    "One or more diet targets are missing. Recommendations should stay low-confidence until check-ins and adherence data are reviewed.",
                    "Calories: %s; protein: %s; goal: %s".formatted(value(phase.getCalorieTarget()), value(phase.getProteinTarget()), goal),
                    ProgressRecommendationPriority.LOW,
                    "DIET_PLAN"
            ));
        }

        if (phase.getStepTarget() == null) {
            recommendations.add(build(
                    member,
                    phase,
                    ProgressRecommendationType.STEPS,
                    "Step target needs review",
                    "Set or confirm a realistic step target for this phase.",
                    "No step target is recorded for this phase, so step compliance cannot be assessed reliably.",
                    "Step target: missing; goal: %s".formatted(goal),
                    ProgressRecommendationPriority.LOW,
                    "STEP_TARGET"
            ));
        }

        int recoveryWarningSigns = countRecoveryWarningSigns(member, phase, week);
        if (recoveryWarningSigns >= 2) {
            recommendations.add(build(
                    member,
                    phase,
                    ProgressRecommendationType.RECOVERY,
                    recoveryWarningSigns >= 3 ? "Deload or recovery review required" : "Recovery review recommended",
                    recoveryWarningSigns >= 3
                            ? "Review recovery and consider a short deload before increasing training stress."
                            : "Check soreness, sleep, stress, pain, and workout quality before progressing.",
                    "Multiple recovery warning signs are present. This is not a diagnosis; if pain or injury needs assessment, refer the member to a qualified medical professional.",
                    "Warning signs: %s; stress level: %s; sleep: %s; injuries: %s; week: %s; workout days: %s".formatted(
                            recoveryWarningSigns,
                            value(member.getStressLevel()),
                            value(member.getSleepHours()),
                            hasText(member.getInjuries()) ? "reported" : "not reported",
                            week,
                            value(phase.getPlannedWorkoutDays())
                    ),
                    recoveryWarningSigns >= 3 ? ProgressRecommendationPriority.HIGH : ProgressRecommendationPriority.MEDIUM,
                    recoveryWarningSigns >= 3 ? "DELOAD" : "OTHER"
            ));
        } else if (week >= 8 && phase.getPlannedWorkoutDays() != null && phase.getPlannedWorkoutDays() >= 4) {
            recommendations.add(build(
                    member,
                    phase,
                    ProgressRecommendationType.RECOVERY,
                    "Deload check suggested",
                    "Review performance and recovery before extending the training block.",
                    "The member is in a longer uninterrupted training block. Do not deload automatically; confirm fatigue, soreness, sleep, and performance first.",
                    "Current week: %s; planned workout days: %s".formatted(week, phase.getPlannedWorkoutDays()),
                    ProgressRecommendationPriority.MEDIUM,
                    "DELOAD"
            ));
        }

        if (recommendations.isEmpty()) {
            recommendations.add(build(
                    member,
                    phase,
                    ProgressRecommendationType.NO_CHANGE,
                    "Keep current plan unchanged",
                    "Continue the current phase and review again on the planned date.",
                    "The current phase is not overdue and has enough targets recorded for now. Avoid unnecessary changes until more check-in, adherence, and performance data supports them.",
                    "Current week: %s; review date: %s; goal: %s".formatted(week, value(phase.getPlannedEndDate()), goal),
                    ProgressRecommendationPriority.LOW,
                    "OTHER"
            ));
        }

        return recommendations;
    }

    private ProgressPlannerRecommendation build(
            Member member,
            CoachingPhase phase,
            ProgressRecommendationType type,
            String title,
            String action,
            String reason,
            String metrics,
            ProgressRecommendationPriority priority,
            String acceptanceChangeType
    ) {
        return ProgressPlannerRecommendation.builder()
                .memberId(member.getId())
                .coachEmail(member.getCoachEmail())
                .phaseId(phase.getId())
                .recommendationType(type)
                .title(title)
                .suggestedAction(action)
                .reason(reason)
                .supportingMetrics(metrics)
                .acceptanceChangeType(acceptanceChangeType)
                .priority(priority)
                .status(ProgressRecommendationStatus.NEW)
                .generatedAt(Instant.now())
                .build();
    }

    private String firstText(String... values) {
        for (String value : values) {
            if (value != null && !value.isBlank()) {
                return value;
            }
        }
        return "-";
    }

    private int countRecoveryWarningSigns(Member member, CoachingPhase phase, long week) {
        int count = 0;
        if (hasText(member.getInjuries())) count++;
        if (containsAny(member.getMedicalCondition(), "pain", "injury", "surgery", "joint", "back", "knee", "shoulder")) count++;
        if (containsAny(member.getMedicalConditionsDetailed(), "pain", "injury", "surgery", "joint", "back", "knee", "shoulder")) count++;
        if (member.getStressLevel() != null && member.getStressLevel() >= 8) count++;
        if (isPoorSleep(member.getSleepHours())) count++;
        if (week >= 8) count++;
        if (phase.getPlannedWorkoutDays() != null && phase.getPlannedWorkoutDays() >= 6) count++;
        return count;
    }

    private boolean hasText(String value) {
        return value != null && !value.isBlank();
    }

    private boolean containsAny(String value, String... terms) {
        if (value == null || value.isBlank()) {
            return false;
        }
        String normalized = value.toLowerCase();
        for (String term : terms) {
            if (normalized.contains(term)) {
                return true;
            }
        }
        return false;
    }

    private boolean isPoorSleep(String value) {
        if (value == null || value.isBlank()) {
            return false;
        }
        String normalized = value.toLowerCase();
        if (containsAny(normalized, "poor", "low", "bad", "less", "insomnia")) {
            return true;
        }
        String digits = normalized.replaceAll("[^0-9.]", " ").trim().split("\\s+")[0];
        try {
            return !digits.isBlank() && Double.parseDouble(digits) < 6;
        } catch (NumberFormatException ex) {
            return false;
        }
    }

    private String value(Object value) {
        return value == null ? "missing" : String.valueOf(value);
    }
}
