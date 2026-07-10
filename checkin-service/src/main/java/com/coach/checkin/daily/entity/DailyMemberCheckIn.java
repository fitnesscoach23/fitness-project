package com.coach.checkin.daily.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(name = "daily_member_checkins")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DailyMemberCheckIn {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(nullable = false)
    private UUID memberId;

    @Column(nullable = false)
    private String coachEmail;

    @Column(nullable = false)
    private LocalDate checkInDate;

    @Column(nullable = false)
    @Builder.Default
    private Boolean exerciseDone = Boolean.FALSE;

    @Column(nullable = false)
    @Builder.Default
    private Boolean workoutNotCompleted = Boolean.FALSE;

    private Integer stepsCount;

    @Column(nullable = false)
    @Builder.Default
    private Boolean stepTargetAchieved = Boolean.FALSE;

    @Column(nullable = false)
    @Builder.Default
    private Boolean travelWorkout = Boolean.FALSE;

    @Column(nullable = false)
    @Builder.Default
    private Boolean recoveryDay = Boolean.FALSE;

    @Column(nullable = false)
    @Builder.Default
    private Boolean activeOther = Boolean.FALSE;

    @Column(nullable = false)
    @Builder.Default
    private Boolean workoutVideoNotShared = Boolean.FALSE;

    @Column(nullable = false)
    @Builder.Default
    private Boolean stepsRecordNotShared = Boolean.FALSE;

    @Column(nullable = false)
    @Builder.Default
    private Boolean notActive = Boolean.FALSE;

    @Column(columnDefinition = "TEXT")
    private String notes;

    @Column(nullable = false, updatable = false)
    private Instant createdAt;

    @Column(nullable = false)
    private Instant updatedAt;

    @PrePersist
    void onCreate() {
        Instant now = Instant.now();
        if (createdAt == null) {
            createdAt = now;
        }
        updatedAt = now;
    }

    @PreUpdate
    void onUpdate() {
        updatedAt = Instant.now();
    }
}
