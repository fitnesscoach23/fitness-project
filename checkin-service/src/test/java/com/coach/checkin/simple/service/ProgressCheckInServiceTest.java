package com.coach.checkin.simple.service;

import com.coach.checkin.simple.dto.CreateProgressCheckInRequest;
import com.coach.checkin.simple.entity.ProgressCheckIn;
import com.coach.checkin.simple.repository.ProgressCheckInRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.verify;
import static org.springframework.http.HttpStatus.NOT_FOUND;
import org.springframework.web.server.ResponseStatusException;

class ProgressCheckInServiceTest {

    private ProgressCheckInRepository repo;
    private ProgressCheckInService service;

    @BeforeEach
    void setUp() {
        repo = mock(ProgressCheckInRepository.class);
        service = new ProgressCheckInService(repo);

        doAnswer(invocation -> {
            ProgressCheckIn entity = invocation.getArgument(0);
            entity.setId(UUID.randomUUID());
            return entity;
        }).when(repo).save(any(ProgressCheckIn.class));
    }

    @Test
    void createShouldPersistExerciseRatingWhenProvided() {
        UUID memberId = UUID.randomUUID();
        Instant submittedAt = Instant.parse("2026-03-20T08:30:00Z");

        service.create("coach@test.com", new CreateProgressCheckInRequest(
                memberId,
                new BigDecimal("81.20"),
                8,
                7,
                9,
                8500,
                "Good training block",
                submittedAt
        ));

        ArgumentCaptor<ProgressCheckIn> captor = ArgumentCaptor.forClass(ProgressCheckIn.class);
        verify(repo).save(captor.capture());

        ProgressCheckIn saved = captor.getValue();
        assertEquals(9, saved.getExerciseRating());
        assertEquals(submittedAt, saved.getSubmittedAt());
    }

    @Test
    void createShouldPersistNullExerciseRatingWhenOmitted() {
        UUID memberId = UUID.randomUUID();

        service.create("coach@test.com", new CreateProgressCheckInRequest(
                memberId,
                new BigDecimal("80.10"),
                7,
                6,
                null,
                7000,
                "No exercise rating",
                null
        ));

        ArgumentCaptor<ProgressCheckIn> captor = ArgumentCaptor.forClass(ProgressCheckIn.class);
        verify(repo).save(captor.capture());

        ProgressCheckIn saved = captor.getValue();
        assertNull(saved.getExerciseRating());
        assertNotNull(saved.getSubmittedAt());
    }

    @Test
    void updateShouldPersistChanges() {
        UUID checkInId = UUID.randomUUID();
        UUID memberId = UUID.randomUUID();
        ProgressCheckIn existing = ProgressCheckIn.builder()
                .id(checkInId)
                .memberId(memberId)
                .coachEmail("coach@test.com")
                .weight(new BigDecimal("80.00"))
                .dietAdherence(6)
                .energy(5)
                .exerciseRating(4)
                .stepsAvg(6000)
                .notes("Old notes")
                .submittedAt(Instant.parse("2026-03-18T10:00:00Z"))
                .build();
        when(repo.findByIdAndCoachEmail(checkInId, "coach@test.com")).thenReturn(Optional.of(existing));

        Instant updatedSubmittedAt = Instant.parse("2026-03-20T10:00:00Z");
        service.update("coach@test.com", checkInId, new CreateProgressCheckInRequest(
                memberId,
                new BigDecimal("60.00"),
                8,
                7,
                9,
                12000,
                "Updated notes",
                updatedSubmittedAt
        ));

        ArgumentCaptor<ProgressCheckIn> captor = ArgumentCaptor.forClass(ProgressCheckIn.class);
        verify(repo).save(captor.capture());

        ProgressCheckIn saved = captor.getValue();
        assertEquals(checkInId, saved.getId());
        assertEquals(memberId, saved.getMemberId());
        assertEquals(new BigDecimal("60.00"), saved.getWeight());
        assertEquals(8, saved.getDietAdherence());
        assertEquals(7, saved.getEnergy());
        assertEquals(9, saved.getExerciseRating());
        assertEquals(12000, saved.getStepsAvg());
        assertEquals("Updated notes", saved.getNotes());
        assertEquals(updatedSubmittedAt, saved.getSubmittedAt());
    }

    @Test
    void updateShouldThrowNotFoundWhenCheckInMissing() {
        UUID checkInId = UUID.randomUUID();
        when(repo.findByIdAndCoachEmail(checkInId, "coach@test.com")).thenReturn(Optional.empty());

        ResponseStatusException ex = assertThrows(ResponseStatusException.class, () ->
                service.update("coach@test.com", checkInId, new CreateProgressCheckInRequest(
                        UUID.randomUUID(),
                        new BigDecimal("60.00"),
                        8,
                        7,
                        9,
                        12000,
                        "Updated notes",
                        Instant.parse("2026-03-20T10:00:00Z")
                ))
        );

        assertEquals(NOT_FOUND, ex.getStatusCode());
    }
}
