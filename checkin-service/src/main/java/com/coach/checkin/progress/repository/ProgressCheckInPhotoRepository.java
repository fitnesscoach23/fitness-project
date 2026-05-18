package com.coach.checkin.progress.repository;

import com.coach.checkin.progress.entity.ProgressCheckInPhoto;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface ProgressCheckInPhotoRepository
        extends JpaRepository<ProgressCheckInPhoto, UUID> {

    List<ProgressCheckInPhoto> findByCheckInId(UUID checkInId);
}
