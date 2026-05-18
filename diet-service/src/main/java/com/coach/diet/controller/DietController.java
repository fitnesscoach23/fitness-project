package com.coach.diet.controller;

import com.coach.diet.dto.*;
import com.coach.diet.service.DietService;
import com.coach.diet.util.CurrentUserUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/diet")
@RequiredArgsConstructor
public class DietController {

    private final DietService service;
    private final CurrentUserUtil current;

    @PostMapping
    public ResponseEntity<?> createPlan(@RequestBody CreateDietPlanRequest req) {
        UUID id = service.createPlan(current.coachEmail(), req);
        return ResponseEntity.ok(id);
    }

    @PostMapping("/{planId}/meals")
    public ResponseEntity<?> addMeal(@PathVariable UUID planId, @RequestBody AddMealRequest req) {
        UUID id = service.addMeal(current.coachEmail(), planId, req);
        return ResponseEntity.ok(id);
    }

    @PostMapping("/meals/{mealId}/items")
    public ResponseEntity<?> addMealItem(@PathVariable UUID mealId, @RequestBody AddMealItemRequest req) {
        UUID id = service.addMealItem(current.coachEmail(), mealId, req);
        return ResponseEntity.ok(id);
    }

    @GetMapping("/{planId}")
    public ResponseEntity<?> getPlan(@PathVariable UUID planId) {
        return ResponseEntity.ok(service.getPlan(current.coachEmail(), planId));
    }

    @GetMapping("/member/{memberId}")
    public ResponseEntity<?> getPlanByMember(@PathVariable UUID memberId) {
        return ResponseEntity.ok(
                service.getPlanByMember(current.coachEmail(), memberId)
        );
    }

    @PutMapping("/meals/{mealId}")
    public ResponseEntity<?> updateMeal(
            @PathVariable UUID mealId,
            @RequestBody UpdateMealRequest req
    ) {
        service.updateMeal(current.coachEmail(), mealId, req);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/meals/{mealId}/full")
    public ResponseEntity<?> saveMeal(
            @PathVariable UUID mealId,
            @RequestBody SaveMealRequest req
    ) {
        service.saveMeal(current.coachEmail(), mealId, req);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/meals/{mealId}")
    public ResponseEntity<?> deleteMeal(@PathVariable UUID mealId) {
        service.deleteMeal(current.coachEmail(), mealId);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/plan/{planId}/full")
    public ResponseEntity<?> saveFullPlan(
            @PathVariable UUID planId,
            @RequestBody SaveDietPlanRequest req
    ) {
        service.saveFullPlan(current.coachEmail(), planId, req);
        return ResponseEntity.ok().build();
    }


    @DeleteMapping("/plan/{planId}")
    public ResponseEntity<?> deletePlan(@PathVariable UUID planId) {
        service.deletePlan(current.coachEmail(), planId);
        return ResponseEntity.ok().build();
    }


}
