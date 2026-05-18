package com.coach.diet.repository;

import com.coach.diet.entity.DietPlan;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface DietPlanRepository extends JpaRepository<DietPlan, UUID> {
    List<DietPlan> findByMemberId(UUID memberId);
    Optional<DietPlan> findTopByMemberIdAndCoachEmailOrderByCreatedAtDesc(
            UUID memberId,
            String coachEmail
    );

}
