package com.coach.workout.repository;

import com.coach.workout.entity.ExerciseLibraryItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface ExerciseLibraryRepository extends JpaRepository<ExerciseLibraryItem, UUID> {
    List<ExerciseLibraryItem> findByCoachEmailOrderByCreatedAtDesc(String coachEmail);

    @Query("""
            select item from ExerciseLibraryItem item
            where item.coachEmail = :coachEmail
              and lower(trim(item.exerciseName)) = lower(trim(:exerciseName))
            """)
    List<ExerciseLibraryItem> findByCoachEmailAndExerciseNameIgnoringCaseAndWhitespace(
            @Param("coachEmail") String coachEmail,
            @Param("exerciseName") String exerciseName
    );
}
