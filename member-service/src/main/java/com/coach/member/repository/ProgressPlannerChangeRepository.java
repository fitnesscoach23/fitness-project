package com.coach.member.repository;

import com.coach.member.entity.ProgressPlannerChange;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface ProgressPlannerChangeRepository extends JpaRepository<ProgressPlannerChange, UUID> {
    List<ProgressPlannerChange> findByCoachEmailAndMemberIdOrderByChangeDateDescCreatedAtDesc(String coachEmail, UUID memberId);
}
