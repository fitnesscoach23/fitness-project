package com.coach.checkin.daily.service;

import com.coach.checkin.daily.dto.DailyMemberCheckInCalendarResponse;
import com.coach.checkin.daily.dto.DailyMemberCheckInDayResponse;
import com.coach.checkin.daily.dto.DailyMemberCheckInSummaryResponse;
import com.coach.checkin.daily.dto.UpsertDailyMemberCheckInRequest;
import com.coach.checkin.daily.entity.DailyMemberCheckIn;
import com.coach.checkin.daily.repository.DailyMemberCheckInRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.web.server.ResponseStatusException;

import java.time.Instant;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.http.HttpStatus.NOT_FOUND;

class DailyMemberCheckInServiceTest {

    private DailyMemberCheckInRepository repository;
    private DailyMemberCheckInService service;

    @BeforeEach
    void setUp() {
        repository = mock(DailyMemberCheckInRepository.class);
        service = new DailyMemberCheckInService(repository);

        doAnswer(invocation -> {
            DailyMemberCheckIn entity = invocation.getArgument(0);
            if (entity.getId() == null) {
                entity.setId(UUID.randomUUID());
            }
            if (entity.getCreatedAt() == null) {
                entity.setCreatedAt(Instant.parse("2026-04-01T00:00:00Z"));
            }
            entity.setUpdatedAt(Instant.parse("2026-04-01T00:05:00Z"));
            return entity;
        }).when(repository).save(any(DailyMemberCheckIn.class));
    }

    @Test
    void upsertShouldCreateNewDailyCheckInWhenDateDoesNotExist() {
        UUID memberId = UUID.randomUUID();
        LocalDate checkInDate = LocalDate.of(2026, 4, 10);
        when(repository.findByMemberIdAndCoachEmailAndCheckInDate(memberId, "coach@test.com", checkInDate))
                .thenReturn(Optional.empty());

        DailyMemberCheckInDayResponse response = service.upsert(
                "coach@test.com",
                new UpsertDailyMemberCheckInRequest(memberId, checkInDate, true, 9000, true, false, false, false, false, "Strong day")
        );

        ArgumentCaptor<DailyMemberCheckIn> captor = ArgumentCaptor.forClass(DailyMemberCheckIn.class);
        verify(repository).save(captor.capture());

        DailyMemberCheckIn saved = captor.getValue();
        assertEquals(memberId, saved.getMemberId());
        assertEquals(checkInDate, saved.getCheckInDate());
        assertTrue(saved.getExerciseDone());
        assertEquals(9000, saved.getStepsCount());
        assertTrue(saved.getStepTargetAchieved());
        assertEquals("Strong day", saved.getNotes());
        assertTrue(response.active());
        assertTrue(response.exerciseDone());
        assertTrue(response.stepTargetAchieved());
        assertNotNull(response.id());
    }

    @Test
    void upsertShouldUpdateExistingDailyCheckInForSameDate() {
        UUID memberId = UUID.randomUUID();
        UUID existingId = UUID.randomUUID();
        LocalDate checkInDate = LocalDate.of(2026, 4, 11);
        DailyMemberCheckIn existing = DailyMemberCheckIn.builder()
                .id(existingId)
                .memberId(memberId)
                .coachEmail("coach@test.com")
                .checkInDate(checkInDate)
                .exerciseDone(false)
                .stepsCount(2000)
                .notes("Old")
                .createdAt(Instant.parse("2026-04-11T00:00:00Z"))
                .updatedAt(Instant.parse("2026-04-11T00:01:00Z"))
                .build();

        when(repository.findByMemberIdAndCoachEmailAndCheckInDate(memberId, "coach@test.com", checkInDate))
                .thenReturn(Optional.of(existing));

        DailyMemberCheckInDayResponse response = service.upsert(
                "coach@test.com",
                new UpsertDailyMemberCheckInRequest(memberId, checkInDate, false, 0, false, false, true, false, false, "Rest day")
        );

        assertEquals(existingId, response.id());
        assertFalse(response.exerciseDone());
        assertTrue(response.active());
        assertTrue(response.recoveryDay());
        assertEquals(0, response.stepsCount());
        assertEquals("Rest day", response.notes());
    }

    @Test
    void getCalendarShouldReturnMonthDaysAndSummary() {
        UUID memberId = UUID.randomUUID();
        YearMonth month = YearMonth.of(2026, 4);

        when(repository.findByMemberIdAndCoachEmailAndCheckInDateBetweenOrderByCheckInDateAsc(
                memberId,
                "coach@test.com",
                month.atDay(1),
                month.atEndOfMonth()
        )).thenReturn(List.of(
                DailyMemberCheckIn.builder()
                        .id(UUID.randomUUID())
                        .memberId(memberId)
                        .coachEmail("coach@test.com")
                        .checkInDate(LocalDate.of(2026, 4, 2))
                        .exerciseDone(true)
                        .stepsCount(8000)
                        .stepTargetAchieved(true)
                        .notes("Training")
                        .createdAt(Instant.parse("2026-04-02T00:00:00Z"))
                        .updatedAt(Instant.parse("2026-04-02T00:01:00Z"))
                        .build(),
                DailyMemberCheckIn.builder()
                        .id(UUID.randomUUID())
                        .memberId(memberId)
                        .coachEmail("coach@test.com")
                        .checkInDate(LocalDate.of(2026, 4, 3))
                        .exerciseDone(false)
                        .stepsCount(3500)
                        .activeOther(true)
                        .notes("Walk only")
                        .createdAt(Instant.parse("2026-04-03T00:00:00Z"))
                        .updatedAt(Instant.parse("2026-04-03T00:01:00Z"))
                        .build(),
                DailyMemberCheckIn.builder()
                        .id(UUID.randomUUID())
                        .memberId(memberId)
                        .coachEmail("coach@test.com")
                        .checkInDate(LocalDate.of(2026, 4, 4))
                        .exerciseDone(false)
                        .stepsCount(0)
                        .notes("Off")
                        .createdAt(Instant.parse("2026-04-04T00:00:00Z"))
                        .updatedAt(Instant.parse("2026-04-04T00:01:00Z"))
                        .build()
        ));

        DailyMemberCheckInCalendarResponse response = service.getCalendar("coach@test.com", memberId, month);
        DailyMemberCheckInSummaryResponse summary = response.summary();

        assertEquals("2026-04", response.month());
        assertEquals(3, response.days().size());
        assertEquals(30, summary.daysInMonth());
        assertEquals(3, summary.recordedDays());
        assertEquals(2, summary.activeDays());
        assertEquals(1, summary.exerciseDays());
        assertEquals(11500, summary.totalSteps());
    }

    @Test
    void deleteShouldThrowNotFoundWhenRecordMissing() {
        UUID checkInId = UUID.randomUUID();
        when(repository.findByIdAndCoachEmail(checkInId, "coach@test.com"))
                .thenReturn(Optional.empty());

        ResponseStatusException exception = assertThrows(ResponseStatusException.class,
                () -> service.delete("coach@test.com", checkInId));

        assertEquals(NOT_FOUND, exception.getStatusCode());
    }
}
