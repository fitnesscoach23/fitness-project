package com.coach.member.repository;

import com.coach.member.entity.CoachingPhase;
import com.coach.member.entity.CoachingPhaseStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface CoachingPhaseRepository extends JpaRepository<CoachingPhase, UUID> {
    List<CoachingPhase> findByCoachEmailAndMemberIdOrderByPhaseNumberAscStartDateAsc(String coachEmail, UUID memberId);

    Optional<CoachingPhase> findFirstByCoachEmailAndMemberIdAndStatusInOrderByStartDateDesc(
            String coachEmail,
            UUID memberId,
            Collection<CoachingPhaseStatus> statuses
    );

    List<CoachingPhase> findByCoachEmailAndMemberIdAndStatusIn(
            String coachEmail,
            UUID memberId,
            Collection<CoachingPhaseStatus> statuses
    );

    @Query("select coalesce(max(p.phaseNumber), 0) from CoachingPhase p where p.coachEmail = :coachEmail and p.memberId = :memberId")
    Integer findMaxPhaseNumber(String coachEmail, UUID memberId);

    List<CoachingPhase> findByCoachEmailAndStatusInOrderByPlannedEndDateAscStartDateAsc(
            String coachEmail,
            Collection<CoachingPhaseStatus> statuses
    );

    List<CoachingPhase> findByCoachEmailAndStatusInAndPlannedEndDateLessThanEqualOrderByPlannedEndDateAsc(
            String coachEmail,
            Collection<CoachingPhaseStatus> statuses,
            LocalDate plannedEndDate
    );
}
