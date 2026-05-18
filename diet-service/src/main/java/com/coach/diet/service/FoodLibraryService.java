package com.coach.diet.service;

import com.coach.diet.dto.FoodLibraryItemResponse;
import com.coach.diet.dto.UpsertFoodLibraryItemRequest;
import com.coach.diet.entity.FoodCategory;
import com.coach.diet.entity.FoodLibraryItem;
import com.coach.diet.repository.FoodLibraryItemRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class FoodLibraryService {

    private final FoodLibraryItemRepository repo;

    public UUID create(UpsertFoodLibraryItemRequest req) {
        FoodLibraryItem item = FoodLibraryItem.builder()
                .foodItem(req.foodItem())
                .calories(req.calories())
                .carbs(req.carbs())
                .protein(req.protein())
                .fats(req.fats())
                .category(req.category())
                .createdAt(Instant.now())
                .build();

        repo.save(item);
        return item.getId();
    }

    public List<FoodLibraryItemResponse> list(FoodCategory category) {
        List<FoodLibraryItem> items = (category == null)
                ? repo.findAllByOrderByFoodItemAsc()
                : repo.findByCategoryOrderByFoodItemAsc(category);

        return items.stream().map(this::toResponse).toList();
    }

    public FoodLibraryItemResponse getById(UUID foodId) {
        FoodLibraryItem item = findOrThrow(foodId);
        return toResponse(item);
    }

    @Transactional
    public void update(UUID foodId, UpsertFoodLibraryItemRequest req) {
        FoodLibraryItem item = findOrThrow(foodId);
        item.setFoodItem(req.foodItem());
        item.setCalories(req.calories());
        item.setCarbs(req.carbs());
        item.setProtein(req.protein());
        item.setFats(req.fats());
        item.setCategory(req.category());
        item.setUpdatedAt(Instant.now());
        repo.save(item);
    }

    public void delete(UUID foodId) {
        FoodLibraryItem item = findOrThrow(foodId);
        repo.delete(item);
    }

    public List<FoodCategory> categories() {
        return List.of(FoodCategory.values());
    }

    private FoodLibraryItem findOrThrow(UUID foodId) {
        return repo.findById(foodId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Food item not found"));
    }

    private FoodLibraryItemResponse toResponse(FoodLibraryItem item) {
        return new FoodLibraryItemResponse(
                item.getId(),
                item.getFoodItem(),
                item.getCalories(),
                item.getCarbs(),
                item.getProtein(),
                item.getFats(),
                item.getCategory()
        );
    }
}
