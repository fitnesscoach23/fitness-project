package com.coach.diet.entity;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "meals")
@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class Meal {
    @Id @GeneratedValue
    private UUID id;

    @Column(nullable = false)
    private UUID planId;
    @Column(nullable = false)
    private String mealName;

    @Column(name = "order_index")
    private Integer orderIndex;

    @Column(name = "created_at", nullable = false)
    private Instant createdAt;
}
