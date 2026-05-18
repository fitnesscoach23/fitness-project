package com.coach.checkin.repository;

import com.coach.checkin.entity.CheckIn;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface CheckInRepository extends JpaRepository<CheckIn, UUID> {
    List<CheckIn> findByMemberIdOrderByCheckInDateDesc(UUID memberId);
}
