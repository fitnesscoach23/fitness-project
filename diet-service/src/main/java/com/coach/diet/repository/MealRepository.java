package com.coach.diet.repository;

import com.coach.diet.entity.Meal;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface MealRepository extends JpaRepository<Meal, UUID> {
    List<Meal> findByPlanId(UUID planId);
}
