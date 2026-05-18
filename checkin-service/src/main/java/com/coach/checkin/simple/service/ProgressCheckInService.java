package com.coach.checkin.simple.service;

import com.coach.checkin.simple.dto.CreateProgressCheckInRequest;
import com.coach.checkin.simple.dto.ProgressCheckInResponse;
import com.coach.checkin.simple.entity.ProgressCheckIn;
import com.coach.checkin.simple.repository.ProgressCheckInRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

import static org.springframework.http.HttpStatus.NOT_FOUND;

@Service
@RequiredArgsConstructor
public class ProgressCheckInService {

    private final ProgressCheckInRepository repo;

    public UUID create(String coachEmail, CreateProgressCheckInRequest req) {
        ProgressCheckIn checkIn = ProgressCheckIn.builder()
                .memberId(req.memberId())
                .coachEmail(coachEmail)
                .weight(req.weight())
                .dietAdherence(req.dietAdherence())
                .energy(req.energy())
                .exerciseRating(req.exerciseRating())
                .stepsAvg(req.stepsAvg())
                .notes(req.notes())
                .submittedAt(req.submittedAt() != null ? req.submittedAt() : Instant.now())
                .build();

        repo.save(checkIn);
        return checkIn.getId();
    }

    public void update(String coachEmail, UUID checkInId, CreateProgressCheckInRequest req) {
        ProgressCheckIn checkIn = repo.findByIdAndCoachEmail(checkInId, coachEmail)
                .orElseThrow(() -> new ResponseStatusException(NOT_FOUND, "Check-in not found"));

        checkIn.setWeight(req.weight());
        checkIn.setDietAdherence(req.dietAdherence());
        checkIn.setEnergy(req.energy());
        checkIn.setExerciseRating(req.exerciseRating());
        checkIn.setStepsAvg(req.stepsAvg());
        checkIn.setNotes(req.notes());
        if (req.submittedAt() != null) {
            checkIn.setSubmittedAt(req.submittedAt());
        }

        repo.save(checkIn);
    }

    public void delete(String coachEmail, UUID checkInId) {
        ProgressCheckIn checkIn = repo.findByIdAndCoachEmail(checkInId, coachEmail)
                .orElseThrow(() -> new ResponseStatusException(NOT_FOUND, "Check-in not found"));

        repo.delete(checkIn);
    }

    public List<ProgressCheckInResponse> getByMember(
            String coachEmail,
            UUID memberId
    ) {
        return repo.findByMemberIdAndCoachEmailOrderBySubmittedAtDesc(
                memberId,
                coachEmail
        ).stream()
         .map(this::toResponse)
         .toList();
    }

    private ProgressCheckInResponse toResponse(ProgressCheckIn e) {
        return new ProgressCheckInResponse(
                e.getId(),
                e.getMemberId(),
                e.getWeight(),
                e.getDietAdherence(),
                e.getEnergy(),
                e.getExerciseRating(),
                e.getStepsAvg(),
                e.getNotes(),
                e.getSubmittedAt()
        );
    }
}
