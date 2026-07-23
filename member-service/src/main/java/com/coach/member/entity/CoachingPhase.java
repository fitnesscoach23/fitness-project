package com.coach.member.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(
        name = "coaching_phases",
        indexes = {
                @Index(name = "idx_coaching_phases_member", columnList = "member_id"),
                @Index(name = "idx_coaching_phases_member_status", columnList = "member_id,status"),
                @Index(name = "idx_coaching_phases_review", columnList = "planned_end_date,status")
        }
)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CoachingPhase {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(name = "member_id", nullable = false)
    private UUID memberId;

    @Column(nullable = false)
    private String coachEmail;

    @Column(nullable = false)
    private Integer phaseNumber;

    @Column(nullable = false)
    private String phaseName;

    private String goal;

    @Column(nullable = false)
    private LocalDate startDate;

    private LocalDate plannedEndDate;
    private LocalDate actualEndDate;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CoachingPhaseStatus status;

    private UUID workoutPlanId;
    private UUID dietPlanId;
    private Integer calorieTarget;
    private BigDecimal proteinTarget;
    private BigDecimal carbTarget;
    private BigDecimal fatTarget;
    private Integer stepTarget;
    private Integer plannedWorkoutDays;

    @Column(columnDefinition = "TEXT")
    private String phaseNotes;

    @Column(columnDefinition = "TEXT")
    private String coachReason;

    @Column(nullable = false)
    private Instant createdAt;

    private Instant updatedAt;
}
