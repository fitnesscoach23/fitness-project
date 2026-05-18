package com.coach.checkin.service;

import com.coach.checkin.dto.CheckInResponse;
import com.coach.checkin.dto.CreateCheckInRequest;
import com.coach.checkin.dto.UpdateCheckInRequest;
import com.coach.checkin.entity.CheckIn;
import com.coach.checkin.entity.Measurement;
import com.coach.checkin.repository.CheckInRepository;
import com.coach.checkin.repository.MeasurementRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CheckInService {

    private final CheckInRepository checkInRepo;
    private final MeasurementRepository measurementRepo;

    public UUID createCheckIn(String coachEmail, CreateCheckInRequest req) {

        CheckIn ci = CheckIn.builder()
                .memberId(req.memberId())
                .coachEmail(coachEmail)
                .checkInDate(LocalDate.now())
                .weight(req.weight())
                .compliance(req.compliance())
                .energy(req.energy())
                .notes(req.notes())
                .createdAt(Instant.now())
                .build();

        checkInRepo.save(ci);

        if (req.measurements() != null) {
            req.measurements().forEach(m ->
                    measurementRepo.save(Measurement.builder()
                            .checkInId(ci.getId())
                            .measurementName(m.name())
                            .value(m.value())
                            .build()
                    )
            );
        }

        return ci.getId();
    }

    public List<CheckInResponse> getCheckIns(String coachEmail, UUID memberId) {
        return checkInRepo.findByMemberIdOrderByCheckInDateDesc(memberId)
                .stream()
                .filter(ci -> ci.getCoachEmail().equals(coachEmail))
                .map(this::toResponse)
                .toList();
    }

    private CheckInResponse toResponse(CheckIn ci) {
        List<Measurement> ms = measurementRepo.findByCheckInId(ci.getId());

        List<CheckInResponse.MeasurementResponse> mrs = ms.stream().map(m ->
                new CheckInResponse.MeasurementResponse(m.getMeasurementName(), m.getValue())
        ).toList();

        return new CheckInResponse(
                ci.getId(),
                ci.getMemberId(),
                ci.getCheckInDate(),
                ci.getWeight(),
                ci.getCompliance(),
                ci.getEnergy(),
                ci.getNotes(),
                ci.getCreatedAt(),
                mrs
        );
    }

    public void updateCheckIn(String coachEmail, UUID checkInId, UpdateCheckInRequest req) {

        CheckIn checkIn = checkInRepo.findById(checkInId)
                .filter(ci -> ci.getCoachEmail().equals(coachEmail))
                .orElseThrow(() -> new RuntimeException("Check-in not found or access denied"));

        // Update basic fields
        checkIn.setCheckInDate(req.checkInDate());
        checkIn.setWeight(req.weight());
        checkIn.setCompliance(req.compliance());
        checkIn.setEnergy(req.energy());
        checkIn.setNotes(req.notes());

        checkInRepo.save(checkIn);

        // Replace measurements (simple + safe approach)
        measurementRepo.deleteByCheckInId(checkInId);

        if (req.measurements() != null) {
            req.measurements().forEach(m ->
                    measurementRepo.save(
                            Measurement.builder()
                                    .checkInId(checkInId)
                                    .measurementName(m.name())
                                    .value(m.value())
                                    .build()
                    )
            );
        }
    }
}
