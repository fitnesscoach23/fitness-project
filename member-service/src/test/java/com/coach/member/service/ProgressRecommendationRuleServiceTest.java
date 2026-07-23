package com.coach.member.service;

import com.coach.member.entity.CoachingPhase;
import com.coach.member.entity.CoachingPhaseStatus;
import com.coach.member.entity.Member;
import com.coach.member.entity.ProgressRecommendationType;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

class ProgressRecommendationRuleServiceTest {

    private final ProgressRecommendationRuleService service = new ProgressRecommendationRuleService();

    @Test
    void generatesOverduePhaseReviewWithoutMutatingPlans() {
        Member member = Member.builder()
                .id(UUID.randomUUID())
                .coachEmail("coach@example.com")
                .fullName("Test Member")
                .mainTrainingGoal("Fat loss")
                .build();
        CoachingPhase phase = CoachingPhase.builder()
                .id(UUID.randomUUID())
                .memberId(member.getId())
                .coachEmail(member.getCoachEmail())
                .phaseName("Fat Loss Phase 1")
                .goal("Fat loss")
                .startDate(LocalDate.now().minusWeeks(7))
                .plannedEndDate(LocalDate.now().minusDays(1))
                .status(CoachingPhaseStatus.ACTIVE)
                .calorieTarget(2000)
                .proteinTarget(new java.math.BigDecimal("120"))
                .stepTarget(8000)
                .plannedWorkoutDays(5)
                .build();

        var recommendations = service.generate(member, phase);

        assertThat(recommendations)
                .anySatisfy(recommendation -> {
                    assertThat(recommendation.getRecommendationType()).isEqualTo(ProgressRecommendationType.PHASE_REVIEW);
                    assertThat(recommendation.getTitle()).containsIgnoringCase("overdue");
                    assertThat(recommendation.getSuggestedAction()).containsIgnoringCase("review");
                });
        assertThat(phase.getCalorieTarget()).isEqualTo(2000);
        assertThat(phase.getStepTarget()).isEqualTo(8000);
    }

    @Test
    void recommendsNoChangeWhenPhaseIsYoungAndTargetsExist() {
        Member member = Member.builder()
                .id(UUID.randomUUID())
                .coachEmail("coach@example.com")
                .fullName("Test Member")
                .mainTrainingGoal("Maintenance")
                .build();
        CoachingPhase phase = CoachingPhase.builder()
                .id(UUID.randomUUID())
                .memberId(member.getId())
                .coachEmail(member.getCoachEmail())
                .phaseName("Maintenance")
                .goal("Maintenance")
                .startDate(LocalDate.now().minusDays(5))
                .plannedEndDate(LocalDate.now().plusWeeks(3))
                .status(CoachingPhaseStatus.ACTIVE)
                .calorieTarget(2200)
                .proteinTarget(new java.math.BigDecimal("130"))
                .stepTarget(7000)
                .build();

        var recommendations = service.generate(member, phase);

        assertThat(recommendations)
                .singleElement()
                .satisfies(recommendation ->
                        assertThat(recommendation.getRecommendationType()).isEqualTo(ProgressRecommendationType.NO_CHANGE)
                );
    }
}
