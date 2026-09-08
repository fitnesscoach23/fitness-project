package com.coach.workout.service;

import com.coach.workout.dto.AddExerciseRequest;
import com.coach.workout.entity.ExerciseLibraryItem;
import com.coach.workout.entity.WorkoutDay;
import com.coach.workout.dto.UpdateWorkoutPlanRequest;
import com.coach.workout.entity.WorkoutPlan;
import com.coach.workout.repository.ExerciseLibraryRepository;
import com.coach.workout.repository.ExerciseRepository;
import com.coach.workout.repository.ExerciseSetRepository;
import com.coach.workout.repository.WorkoutDayRepository;
import com.coach.workout.repository.WorkoutPlanRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.server.ResponseStatusException;

import java.time.Instant;
import java.util.Optional;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.http.HttpStatus.NOT_FOUND;

@ExtendWith(MockitoExtension.class)
class WorkoutServiceTest {

    @Mock
    private WorkoutPlanRepository planRepo;

    @Mock
    private WorkoutDayRepository dayRepo;

    @Mock
    private ExerciseRepository exerciseRepo;

    @Mock
    private ExerciseSetRepository setRepo;

    @Mock
    private ExerciseLibraryRepository libraryRepo;

    @InjectMocks
    private WorkoutService service;

    @Test
    void updatePlanUpdatesTitleAndNotes() {
        UUID planId = UUID.randomUUID();
        WorkoutPlan plan = WorkoutPlan.builder()
                .id(planId)
                .memberId(UUID.randomUUID())
                .coachEmail("coach@example.com")
                .title("Old Title")
                .notes("Old Notes")
                .targetStepsCount(7000)
                .createdAt(Instant.now())
                .build();

        when(planRepo.findById(planId)).thenReturn(Optional.of(plan));

        service.updatePlan(
                "coach@example.com",
                planId,
                new UpdateWorkoutPlanRequest("Updated Title", "Updated Notes", 9000)
        );

        assertEquals("Updated Title", plan.getTitle());
        assertEquals("Updated Notes", plan.getNotes());
        assertEquals(9000, plan.getTargetStepsCount());
        verify(planRepo).save(plan);
    }

    @Test
    void updatePlanThrowsNotFoundWhenPlanDoesNotExist() {
        UUID planId = UUID.randomUUID();
        when(planRepo.findById(planId)).thenReturn(Optional.empty());

        ResponseStatusException exception = assertThrows(
                ResponseStatusException.class,
                () -> service.updatePlan(
                        "coach@example.com",
                        planId,
                        new UpdateWorkoutPlanRequest("Updated Title", "Updated Notes", 9000)
                )
        );

        assertEquals(NOT_FOUND, exception.getStatusCode());
        assertEquals("Plan not found", exception.getReason());
    }

    @Test
    void updatePlanThrowsNotFoundForDifferentCoachOwnership() {
        UUID planId = UUID.randomUUID();
        WorkoutPlan plan = WorkoutPlan.builder()
                .id(planId)
                .memberId(UUID.randomUUID())
                .coachEmail("other-coach@example.com")
                .title("Old Title")
                .notes("Old Notes")
                .createdAt(Instant.now())
                .build();

        when(planRepo.findById(planId)).thenReturn(Optional.of(plan));

        ResponseStatusException exception = assertThrows(
                ResponseStatusException.class,
                () -> service.updatePlan(
                        "coach@example.com",
                        planId,
                        new UpdateWorkoutPlanRequest("Updated Title", "Updated Notes", 9000)
                )
        );

        assertEquals(NOT_FOUND, exception.getStatusCode());
        assertEquals("Plan not found", exception.getReason());
    }

    @Test
    void deleteDayDoesNothingWhenDayAlreadyDeleted() {
        UUID dayId = UUID.randomUUID();
        when(dayRepo.findById(dayId)).thenReturn(Optional.empty());

        service.deleteDay("coach@example.com", dayId);

        verify(exerciseRepo, never()).findByDayId(dayId);
        verify(dayRepo, never()).delete(org.mockito.ArgumentMatchers.any());
    }

    @Test
    void addExerciseUpdatesVideoForMatchingLibraryExercise() {
        UUID planId = UUID.randomUUID();
        UUID dayId = UUID.randomUUID();
        WorkoutPlan plan = WorkoutPlan.builder()
                .id(planId)
                .coachEmail("coach@example.com")
                .build();
        WorkoutDay day = WorkoutDay.builder().id(dayId).planId(planId).build();
        ExerciseLibraryItem libraryExercise = ExerciseLibraryItem.builder()
                .exerciseName("  Bench Press  ")
                .videoUrl("https://old.example/video")
                .build();

        when(dayRepo.findById(dayId)).thenReturn(Optional.of(day));
        when(planRepo.findById(planId)).thenReturn(Optional.of(plan));
        when(libraryRepo.findByCoachEmailAndExerciseNameIgnoringCaseAndWhitespace(
                "coach@example.com", "bench press"))
                .thenReturn(List.of(libraryExercise));

        service.addExercise("coach@example.com", dayId, new AddExerciseRequest(
                "bench press", null, null, null, "https://new.example/video"));

        assertEquals("https://new.example/video", libraryExercise.getVideoUrl());
        verify(libraryRepo).saveAll(List.of(libraryExercise));
    }
}
