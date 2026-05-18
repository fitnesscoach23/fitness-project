package com.coach.checkin.daily.repository;

import com.coach.checkin.daily.entity.DailyMemberCheckIn;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface DailyMemberCheckInRepository extends JpaRepository<DailyMemberCheckIn, UUID> {

    Optional<DailyMemberCheckIn> findByMemberIdAndCoachEmailAndCheckInDate(
            UUID memberId,
            String coachEmail,
            LocalDate checkInDate
    );

    Optional<DailyMemberCheckIn> findByIdAndCoachEmail(UUID id, String coachEmail);

    List<DailyMemberCheckIn> findByMemberIdAndCoachEmailAndCheckInDateBetweenOrderByCheckInDateAsc(
            UUID memberId,
            String coachEmail,
            LocalDate startDate,
            LocalDate endDate
    );
}
