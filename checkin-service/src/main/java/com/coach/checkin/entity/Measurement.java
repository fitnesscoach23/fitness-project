package com.coach.checkin.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.UUID;

@Entity
@Table(name = "measurements")
@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class Measurement {
    @Id @GeneratedValue
    private UUID id;
    @Column(nullable = false)
    private UUID checkInId;
    @Column(nullable = false)
    private String measurementName;
    @Column(nullable = false)
    private BigDecimal value;
}
