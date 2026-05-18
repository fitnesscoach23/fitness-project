package com.coach.diet.service;

import com.coach.diet.dto.*;
import com.coach.diet.entity.*;
import com.coach.diet.repository.*;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DietService {

    private final DietPlanRepository planRepo;
    private final MealRepository mealRepo;
    private final MealItemRepository itemRepo;

    public UUID createPlan(String coachEmail, CreateDietPlanRequest req) {
        DietPlan plan = DietPlan.builder()
                .memberId(req.memberId())
                .coachEmail(coachEmail)
                .title(req.title())
                .notes(req.notes())
                .createdAt(Instant.now())
                .build();

        planRepo.save(plan);
        return plan.getId();
    }

    public UUID addMeal(String coachEmail, UUID planId, AddMealRequest req) {
        DietPlan plan = assertOwnedPlan(coachEmail, planId);

        Integer orderIndex = req.orderIndex();
        if (orderIndex == null) {
            orderIndex = nextMealOrderIndex(planId);
        }

        Meal meal = Meal.builder()
                .planId(planId)
                .mealName(req.mealName())
                .orderIndex(orderIndex)
                .createdAt(Instant.now())
                .build();

        mealRepo.save(meal);
        return meal.getId();
    }

    public UUID addMealItem(String coachEmail, UUID mealId, AddMealItemRequest req) {
        Meal meal = mealRepo.findById(mealId)
                .orElseThrow(() -> new RuntimeException("Meal not found"));

        assertOwnedPlan(coachEmail, meal.getPlanId());

        MealItem item = MealItem.builder()
                .mealId(mealId)
                .foodName(req.foodName())
                .quantity(req.quantity())
                .unit(req.unit())
                .build();

        itemRepo.save(item);
        return item.getId();
    }

    public DietPlanResponse getPlan(String coachEmail, UUID planId) {
        DietPlan plan = assertOwnedPlan(coachEmail, planId);

        List<Meal> meals = mealRepo.findByPlanId(planId);
        meals.sort(this::compareMealsByOrderThenCreatedAt);

        List<DietPlanResponse.Meal> mealResponses = meals.stream().map(meal -> {
            List<MealItem> items = itemRepo.findByMealId(meal.getId());

            List<DietPlanResponse.MealItem> itemResponses =
                    items.stream().map(it ->
                            new DietPlanResponse.MealItem(
                                    it.getId(),
                                    it.getFoodName(),
                                    it.getQuantity(),
                                    it.getUnit(),
                                    it.getProtein(),
                                    it.getCarbs(),
                                    it.getFat(),
                                    it.getCalories()
                            )
                    ).toList();

            return new DietPlanResponse.Meal(
                    meal.getId(),
                    meal.getMealName(),
                    meal.getOrderIndex(),
                    itemResponses
            );
        }).toList();

        return new DietPlanResponse(
                plan.getId(),
                plan.getMemberId(),
                plan.getTitle(),
                plan.getNotes(),
                plan.getCreatedAt(),
                mealResponses
        );
    }

    private DietPlan assertOwnedPlan(String coachEmail, UUID planId) {
        return planRepo.findById(planId)
                .filter(plan -> plan.getCoachEmail().equals(coachEmail))
                .orElseThrow(() -> new RuntimeException("Plan not found"));
    }

    public DietPlanResponse getPlanByMember(String coachEmail, UUID memberId) {

        DietPlan plan = planRepo
                .findTopByMemberIdAndCoachEmailOrderByCreatedAtDesc(memberId, coachEmail)
                .orElseThrow(() -> new RuntimeException("Diet plan not found"));

        return getPlan(coachEmail, plan.getId());
    }

    public void updateMeal(
            String coachEmail,
            UUID mealId,
            UpdateMealRequest req
    ) {
        Meal meal = mealRepo.findById(mealId)
                .orElseThrow(() -> new RuntimeException("Meal not found"));

        // ownership check via plan
        assertOwnedPlan(coachEmail, meal.getPlanId());

        meal.setMealName(req.mealName());
        if (req.orderIndex() != null) {
            meal.setOrderIndex(req.orderIndex());
        }
        mealRepo.save(meal);
    }

    @Transactional
    public void saveMeal(
            String coachEmail,
            UUID mealId,
            SaveMealRequest req
    ) {
        Meal meal = mealRepo.findById(mealId)
                .orElseThrow(() -> new RuntimeException("Meal not found"));

        // ownership check
        assertOwnedPlan(coachEmail, meal.getPlanId());

        // update meal name
        meal.setMealName(req.mealName());
        if (req.orderIndex() != null) {
            meal.setOrderIndex(req.orderIndex());
        }
        mealRepo.save(meal);

        // existing items
        List<MealItem> existingItems = itemRepo.findByMealId(mealId);

        // map by id
        Map<UUID, MealItem> existingMap = existingItems.stream()
                .collect(Collectors.toMap(MealItem::getId, it -> it));

        // incoming ids
        Set<UUID> incomingIds = req.items().stream()
                .map(SaveMealRequest.MealItemDto::id)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        // delete removed items
        existingItems.stream()
                .filter(it -> !incomingIds.contains(it.getId()))
                .forEach(itemRepo::delete);

        // upsert items
        for (SaveMealRequest.MealItemDto dto : req.items()) {
            if (dto.id() != null) {
                MealItem item = existingMap.get(dto.id());
                item.setFoodName(dto.foodName());
                item.setQuantity(dto.quantity());
                item.setUnit(dto.unit());
                itemRepo.save(item);
            } else {
                MealItem item = MealItem.builder()
                        .mealId(mealId)
                        .foodName(dto.foodName())
                        .quantity(dto.quantity())
                        .unit(dto.unit())
                        .build();
                itemRepo.save(item);
            }
        }
    }

    @Transactional
    public void deleteMeal(String coachEmail, UUID mealId) {

        Meal meal = mealRepo.findById(mealId)
                .orElseThrow(() -> new RuntimeException("Meal not found"));

        // ownership check
        assertOwnedPlan(coachEmail, meal.getPlanId());

        // delete items first
        itemRepo.deleteByMealId(mealId);

        // delete meal
        mealRepo.delete(meal);
    }

    @Transactional
    public void saveFullPlan(
            String coachEmail,
            UUID planId,
            SaveDietPlanRequest req
    ) {
        DietPlan plan = assertOwnedPlan(coachEmail, planId);

        // update plan meta
        plan.setTitle(req.title());
        plan.setNotes(req.notes());
        plan.setUpdatedAt(Instant.now());
        planRepo.save(plan);

        // fetch existing meals
        List<Meal> existingMeals = mealRepo.findByPlanId(planId);

        // delete items first
        for (Meal meal : existingMeals) {
            itemRepo.deleteByMealId(meal.getId());
        }

        // delete meals
        mealRepo.deleteAll(existingMeals);

        // rebuild from rows
        Map<String, List<DietRowDto>> byMeal =
                req.rows().stream()
                        .collect(Collectors.groupingBy(
                                DietRowDto::mealType,
                                LinkedHashMap::new,
                                Collectors.toList()
                        ));

        int orderIndex = 0;
        for (Map.Entry<String, List<DietRowDto>> entry : byMeal.entrySet()) {

            Meal meal = Meal.builder()
                    .planId(planId)
                    .mealName(entry.getKey())
                    .orderIndex(orderIndex++)
                    .createdAt(Instant.now())
                    .build();

            mealRepo.save(meal);

            for (DietRowDto row : entry.getValue()) {
                MealItem item = MealItem.builder()
                        .mealId(meal.getId())
                        .foodName(row.foodName())
                        .quantity(row.quantity())
                        .unit(row.unit())
                        .protein(row.protein())
                        .carbs(row.carbs())
                        .fat(row.fat())
                        .calories(row.calories())
                        .build();

                itemRepo.save(item);
            }
        }
    }


    @Transactional
    public void deletePlan(String coachEmail, UUID planId) {
        DietPlan plan = assertOwnedPlan(coachEmail, planId);

        List<Meal> meals = mealRepo.findByPlanId(planId);

        for (Meal meal : meals) {
            itemRepo.deleteByMealId(meal.getId());
        }

        mealRepo.deleteAll(meals);
        planRepo.delete(plan);
    }

    private int nextMealOrderIndex(UUID planId) {
        return mealRepo.findByPlanId(planId).stream()
                .map(Meal::getOrderIndex)
                .filter(Objects::nonNull)
                .max(Integer::compareTo)
                .map(max -> max + 1)
                .orElse(0);
    }

    private int compareMealsByOrderThenCreatedAt(Meal a, Meal b) {
        Integer aIdx = a.getOrderIndex();
        Integer bIdx = b.getOrderIndex();
        if (aIdx != null && bIdx != null) {
            return aIdx.compareTo(bIdx);
        }
        if (aIdx != null) {
            return -1;
        }
        if (bIdx != null) {
            return 1;
        }
        Instant aCreated = a.getCreatedAt();
        Instant bCreated = b.getCreatedAt();
        if (aCreated == null && bCreated == null) {
            return 0;
        }
        if (aCreated == null) {
            return 1;
        }
        if (bCreated == null) {
            return -1;
        }
        return aCreated.compareTo(bCreated);
    }
}
