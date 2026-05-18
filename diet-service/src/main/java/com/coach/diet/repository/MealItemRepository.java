package com.coach.diet.repository;

import com.coach.diet.entity.MealItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface MealItemRepository extends JpaRepository<MealItem, UUID> {
    List<MealItem> findByMealId(UUID mealId);
    void deleteByMealId(UUID mealId);

}
