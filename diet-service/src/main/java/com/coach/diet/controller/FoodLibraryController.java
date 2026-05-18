package com.coach.diet.controller;

import com.coach.diet.dto.FoodLibraryItemResponse;
import com.coach.diet.dto.UpsertFoodLibraryItemRequest;
import com.coach.diet.entity.FoodCategory;
import com.coach.diet.service.FoodLibraryService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/diet-library")
@RequiredArgsConstructor
public class FoodLibraryController {

    private final FoodLibraryService service;

    @PostMapping("/foods")
    public ResponseEntity<?> createFood(@Valid @RequestBody UpsertFoodLibraryItemRequest req) {
        UUID id = service.create(req);
        return ResponseEntity.ok(Map.of("id", id));
    }

    @GetMapping("/foods")
    public ResponseEntity<List<FoodLibraryItemResponse>> listFoods(
            @RequestParam(required = false) FoodCategory category
    ) {
        return ResponseEntity.ok(service.list(category));
    }

    @GetMapping("/foods/{foodId}")
    public ResponseEntity<FoodLibraryItemResponse> getFood(@PathVariable UUID foodId) {
        return ResponseEntity.ok(service.getById(foodId));
    }

    @PutMapping("/foods/{foodId}")
    public ResponseEntity<?> updateFood(
            @PathVariable UUID foodId,
            @Valid @RequestBody UpsertFoodLibraryItemRequest req
    ) {
        service.update(foodId, req);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/foods/{foodId}")
    public ResponseEntity<?> deleteFood(@PathVariable UUID foodId) {
        service.delete(foodId);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/categories")
    public ResponseEntity<List<FoodCategory>> listCategories() {
        return ResponseEntity.ok(service.categories());
    }
}
