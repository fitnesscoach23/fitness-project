package com.coach.member.repository;

import com.coach.member.entity.ProgressPlannerRecommendation;
import com.coach.member.entity.ProgressRecommendationStatus;
import com.coach.member.entity.ProgressRecommendationType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ProgressPlannerRecommendationRepository extends JpaRepository<ProgressPlannerRecommendation, UUID> {
    List<ProgressPlannerRecommendation> findByCoachEmailAndMemberIdOrderByGeneratedAtDesc(String coachEmail, UUID memberId);

    List<ProgressPlannerRecommendation> findByCoachEmailAndStatusInOrderByPriorityDescGeneratedAtDesc(
            String coachEmail,
            Collection<ProgressRecommendationStatus> statuses
    );

    Optional<ProgressPlannerRecommendation> findFirstByCoachEmailAndMemberIdAndPhaseIdAndRecommendationTypeAndStatusIn(
            String coachEmail,
            UUID memberId,
            UUID phaseId,
            ProgressRecommendationType type,
            Collection<ProgressRecommendationStatus> statuses
    );
}
