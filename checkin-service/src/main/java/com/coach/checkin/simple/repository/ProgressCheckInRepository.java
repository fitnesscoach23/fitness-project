package com.coach.checkin.simple.repository;

import com.coach.checkin.simple.entity.ProgressCheckIn;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ProgressCheckInRepository
        extends JpaRepository<ProgressCheckIn, UUID> {

    Optional<ProgressCheckIn> findByIdAndCoachEmail(UUID id, String coachEmail);

    List<ProgressCheckIn> findByMemberIdAndCoachEmailOrderBySubmittedAtDesc(
            UUID memberId,
            String coachEmail
    );
}
