package com.coach.checkin.simple.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "progress_checkins")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProgressCheckIn {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(nullable = false)
    private UUID memberId;

    @Column(nullable = false)
    private String coachEmail;

    @Column(nullable = false)
    private Instant submittedAt;

    private BigDecimal weight;
    private Integer dietAdherence;
    private Integer energy;
    private Integer exerciseRating;
    private Integer stepsAvg;

    @Column(columnDefinition = "TEXT")
    private String notes;
}
