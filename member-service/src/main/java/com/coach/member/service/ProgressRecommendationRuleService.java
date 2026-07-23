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

    private String value(Object value) {
        return value == null ? "missing" : String.valueOf(value);
    }
}
