package com.coach.member.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(
        name = "progress_planner_recommendations",
        indexes = {
                @Index(name = "idx_progress_recommendations_member", columnList = "coach_email,member_id"),
                @Index(name = "idx_progress_recommendations_phase", columnList = "phase_id"),
                @Index(name = "idx_progress_recommendations_status", columnList = "coach_email,status,priority")
        }
)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProgressPlannerRecommendation {

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
    private ProgressRecommendationType recommendationType;

    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String suggestedAction;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String reason;

    @Column(columnDefinition = "TEXT")
    private String supportingMetrics;

    @Column(columnDefinition = "TEXT")
    private String acceptanceChangeType;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ProgressRecommendationPriority priority;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ProgressRecommendationStatus status;

    @Column(nullable = false)
    private Instant generatedAt;

    private Instant reviewedAt;

    @Column(columnDefinition = "TEXT")
    private String coachDecisionNotes;
}
