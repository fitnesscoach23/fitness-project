package com.coach.diet.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Entity
@Table(name = "meal_items")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MealItem {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(nullable = false)
    private UUID mealId;

    @Column(nullable = false)
    private String foodName;

    @Column(nullable = false)
    private Integer quantity;

    @Column(nullable = false)
    private String unit;

    private Integer protein;
    private Integer carbs;
    private Integer fat;
    private Integer calories;
}
