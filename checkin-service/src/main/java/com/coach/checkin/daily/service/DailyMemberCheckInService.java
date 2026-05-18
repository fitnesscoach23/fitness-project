package com.coach.checkin.daily.service;

import com.coach.checkin.daily.dto.DailyMemberCheckInCalendarResponse;
import com.coach.checkin.daily.dto.DailyMemberCheckInDayResponse;
import com.coach.checkin.daily.dto.DailyMemberCheckInSummaryResponse;
import com.coach.checkin.daily.dto.UpsertDailyMemberCheckInRequest;
import com.coach.checkin.daily.entity.DailyMemberCheckIn;
import com.coach.checkin.daily.repository.DailyMemberCheckInRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.YearMonth;
import java.util.List;
import java.util.UUID;

import static org.springframework.http.HttpStatus.NOT_FOUND;

@Service
@RequiredArgsConstructor
public class DailyMemberCheckInService {

    private final DailyMemberCheckInRepository repository;

    public DailyMemberCheckInDayResponse upsert(String coachEmail, UpsertDailyMemberCheckInRequest request) {
        DailyMemberCheckIn checkIn = repository.findByMemberIdAndCoachEmailAndCheckInDate(
                        request.memberId(),
                        coachEmail,
                        request.checkInDate()
                )
                .orElseGet(() -> DailyMemberCheckIn.builder()
                        .memberId(request.memberId())
                        .coachEmail(coachEmail)
                        .checkInDate(request.checkInDate())
                        .build());

        checkIn.setExerciseDone(Boolean.TRUE.equals(request.exerciseDone()));
        checkIn.setStepsCount(request.stepsCount());
        checkIn.setNotes(request.notes());

        return toDayResponse(repository.save(checkIn));
    }

    public void delete(String coachEmail, UUID checkInId) {
        DailyMemberCheckIn checkIn = repository.findByIdAndCoachEmail(checkInId, coachEmail)
                .orElseThrow(() -> new ResponseStatusException(NOT_FOUND, "Daily check-in not found"));
        repository.delete(checkIn);
    }

    public DailyMemberCheckInCalendarResponse getCalendar(String coachEmail, UUID memberId, YearMonth month) {
        List<DailyMemberCheckInDayResponse> days = repository
                .findByMemberIdAndCoachEmailAndCheckInDateBetweenOrderByCheckInDateAsc(
                        memberId,
                        coachEmail,
                        month.atDay(1),
                        month.atEndOfMonth()
                ).stream()
                .map(this::toDayResponse)
                .toList();

        return new DailyMemberCheckInCalendarResponse(
                memberId,
                month.toString(),
                days,
                buildSummary(month, days)
        );
    }

    public DailyMemberCheckInSummaryResponse getSummary(String coachEmail, UUID memberId, YearMonth month) {
        return getCalendar(coachEmail, memberId, month).summary();
    }

    private DailyMemberCheckInSummaryResponse buildSummary(
            YearMonth month,
            List<DailyMemberCheckInDayResponse> days
    ) {
        int activeDays = (int) days.stream()
                .filter(DailyMemberCheckInDayResponse::active)
                .count();

        int exerciseDays = (int) days.stream()
                .filter(DailyMemberCheckInDayResponse::exerciseDone)
                .count();

        int totalSteps = days.stream()
                .map(DailyMemberCheckInDayResponse::stepsCount)
                .filter(value -> value != null && value > 0)
                .mapToInt(Integer::intValue)
                .sum();

        return new DailyMemberCheckInSummaryResponse(
                month.lengthOfMonth(),
                days.size(),
                activeDays,
                exerciseDays,
                totalSteps
        );
    }

    private DailyMemberCheckInDayResponse toDayResponse(DailyMemberCheckIn checkIn) {
        boolean active = Boolean.TRUE.equals(checkIn.getExerciseDone())
                || (checkIn.getStepsCount() != null && checkIn.getStepsCount() > 0);

        return new DailyMemberCheckInDayResponse(
                checkIn.getId(),
                checkIn.getCheckInDate(),
                Boolean.TRUE.equals(checkIn.getExerciseDone()),
                checkIn.getStepsCount(),
                active,
                checkIn.getNotes(),
                checkIn.getCreatedAt(),
                checkIn.getUpdatedAt()
        );
    }
}
