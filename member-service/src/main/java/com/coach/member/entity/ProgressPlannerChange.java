package com.coach.member.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(
        name = "progress_planner_changes",
        indexes = {
                @Index(name = "idx_progress_planner_changes_member", columnList = "member_id"),
                @Index(name = "idx_progress_planner_changes_phase", columnList = "phase_id"),
                @Index(name = "idx_progress_planner_changes_timeline", columnList = "member_id,change_date,created_at")
        }
)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProgressPlannerChange {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(name = "member_id", nullable = false)
    private UUID memberId;

    @Column(nullable = false)
    private String coachEmail;

    @Column(name = "phase_id")
    private UUID phaseId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ProgressPlannerChangeType changeType;

    @Column(nullable = false)
    private LocalDate changeDate;

    @Column(columnDefinition = "TEXT")
    private String previousValue;

    @Column(columnDefinition = "TEXT")
    private String newValue;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String reason;

    @Column(columnDefinition = "TEXT")
    private String coachNotes;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ProgressPlannerChangeSource source;

    @Column(nullable = false)
    private String createdBy;

    @Column(nullable = false)
    private Instant createdAt;
}
