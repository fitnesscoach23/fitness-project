package com.coach.checkin.repository;

import com.coach.checkin.entity.CheckInPhoto;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface CheckInPhotoRepository extends JpaRepository<CheckInPhoto, UUID> {
    List<CheckInPhoto> findByCheckInId(UUID checkInId);
}
