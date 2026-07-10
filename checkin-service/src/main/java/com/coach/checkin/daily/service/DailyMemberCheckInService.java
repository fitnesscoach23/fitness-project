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

        boolean hasPositiveSteps = request.stepsCount() != null && request.stepsCount() > 0;
        boolean notActive = Boolean.TRUE.equals(request.notActive()) && !hasPositiveSteps;
        boolean exerciseDone = !notActive && Boolean.TRUE.equals(request.exerciseDone());
        checkIn.setExerciseDone(exerciseDone);
        checkIn.setWorkoutNotCompleted(!exerciseDone && Boolean.TRUE.equals(request.workoutNotCompleted()));
        checkIn.setStepsCount(notActive ? 0 : request.stepsCount());
        checkIn.setStepTargetAchieved(!notActive && Boolean.TRUE.equals(request.stepTargetAchieved()));
        checkIn.setTravelWorkout(!notActive && Boolean.TRUE.equals(request.travelWorkout()));
        checkIn.setRecoveryDay(!notActive && Boolean.TRUE.equals(request.recoveryDay()));
        checkIn.setActiveOther(!notActive && Boolean.TRUE.equals(request.activeOther()));
        checkIn.setWorkoutVideoNotShared(Boolean.TRUE.equals(request.workoutVideoNotShared()));
        checkIn.setStepsRecordNotShared(Boolean.TRUE.equals(request.stepsRecordNotShared()));
        checkIn.setNotActive(notActive);
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
        boolean stepTargetAchieved = Boolean.TRUE.equals(checkIn.getStepTargetAchieved());
        boolean workoutNotCompleted = Boolean.TRUE.equals(checkIn.getWorkoutNotCompleted());
        boolean travelWorkout = Boolean.TRUE.equals(checkIn.getTravelWorkout());
        boolean recoveryDay = Boolean.TRUE.equals(checkIn.getRecoveryDay());
        boolean activeOther = Boolean.TRUE.equals(checkIn.getActiveOther());
        boolean workoutVideoNotShared = Boolean.TRUE.equals(checkIn.getWorkoutVideoNotShared());
        boolean stepsRecordNotShared = Boolean.TRUE.equals(checkIn.getStepsRecordNotShared());
        boolean notActive = Boolean.TRUE.equals(checkIn.getNotActive());
        boolean hasPositiveSteps = checkIn.getStepsCount() != null && checkIn.getStepsCount() > 0;
        boolean active = Boolean.TRUE.equals(checkIn.getExerciseDone())
                || stepTargetAchieved
                || travelWorkout
                || recoveryDay
                || activeOther
                || hasPositiveSteps;

        return new DailyMemberCheckInDayResponse(
                checkIn.getId(),
                checkIn.getCheckInDate(),
                Boolean.TRUE.equals(checkIn.getExerciseDone()),
                workoutNotCompleted,
                checkIn.getStepsCount(),
                stepTargetAchieved,
                travelWorkout,
                recoveryDay,
                activeOther,
                workoutVideoNotShared,
                stepsRecordNotShared,
                notActive,
                active,
                checkIn.getNotes(),
                checkIn.getCreatedAt(),
                checkIn.getUpdatedAt()
        );
    }
}
