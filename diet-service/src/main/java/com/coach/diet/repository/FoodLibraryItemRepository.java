package com.coach.diet.repository;

import com.coach.diet.entity.FoodCategory;
import com.coach.diet.entity.FoodLibraryItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface FoodLibraryItemRepository extends JpaRepository<FoodLibraryItem, UUID> {
    List<FoodLibraryItem> findAllByOrderByFoodItemAsc();

    List<FoodLibraryItem> findByCategoryOrderByFoodItemAsc(FoodCategory category);
}
