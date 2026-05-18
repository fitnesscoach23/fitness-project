package com.coach.checkin.repository;

import com.coach.checkin.entity.Measurement;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface MeasurementRepository extends JpaRepository<Measurement, UUID> {
    List<Measurement> findByCheckInId(UUID checkInId);
    void deleteByCheckInId(UUID checkInId);
}
