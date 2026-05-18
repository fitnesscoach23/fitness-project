package com.coach.checkin.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(name = "checkins")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CheckIn {
    @Id
    @GeneratedValue
    private UUID id;

    @Column(nullable = false)
    private UUID memberId;
    @Column(nullable = false)
    private String coachEmail;
    @Column(nullable = false)
    private LocalDate checkInDate;

    private BigDecimal weight;
    private Integer compliance;
    private Integer energy;
    private String notes;
    @Column(nullable = false)
    private Instant createdAt;
}
