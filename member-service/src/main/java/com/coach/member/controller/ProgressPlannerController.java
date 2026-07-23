package com.coach.member.controller;

import com.coach.member.dto.*;
import com.coach.member.service.ProgressPlannerService;
import com.coach.member.util.CurrentUserUtil;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class ProgressPlannerController {

    private final ProgressPlannerService service;
    private final CurrentUserUtil current;

    @GetMapping("/members/{memberId}/progress-planner")
    public ResponseEntity<ProgressPlannerOverviewResponse> overview(@PathVariable UUID memberId) {
        return ResponseEntity.ok(service.getOverview(current.getCoachEmail(), memberId));
    }

    @GetMapping("/members/{memberId}/phases")
    public ResponseEntity<List<CoachingPhaseResponse>> phases(@PathVariable UUID memberId) {
        return ResponseEntity.ok(service.getPhases(current.getCoachEmail(), memberId));
    }

    @PostMapping("/members/{memberId}/phases")
    public ResponseEntity<CoachingPhaseResponse> createPhase(
            @PathVariable UUID memberId,
            @Valid @RequestBody CoachingPhaseRequest request
    ) {
        return ResponseEntity.ok(service.createPhase(current.getCoachEmail(), memberId, request));
    }

    @PutMapping("/members/{memberId}/phases/{phaseId}")
    public ResponseEntity<CoachingPhaseResponse> updatePhase(
            @PathVariable UUID memberId,
            @PathVariable UUID phaseId,
            @Valid @RequestBody CoachingPhaseRequest request
    ) {
        return ResponseEntity.ok(service.updatePhase(current.getCoachEmail(), memberId, phaseId, request));
    }

    @PostMapping("/members/{memberId}/phases/{phaseId}/complete")
    public ResponseEntity<CoachingPhaseResponse> completePhase(
            @PathVariable UUID memberId,
            @PathVariable UUID phaseId,
            @Valid @RequestBody PhaseLifecycleRequest request
    ) {
        return ResponseEntity.ok(service.completePhase(current.getCoachEmail(), memberId, phaseId, request));
    }

    @PostMapping("/members/{memberId}/phases/{phaseId}/pause")
    public ResponseEntity<CoachingPhaseResponse> pausePhase(
            @PathVariable UUID memberId,
            @PathVariable UUID phaseId,
            @Valid @RequestBody PhaseLifecycleRequest request
    ) {
        return ResponseEntity.ok(service.pausePhase(current.getCoachEmail(), memberId, phaseId, request));
    }

    @GetMapping("/members/{memberId}/change-history")
    public ResponseEntity<List<ProgressPlannerChangeResponse>> changeHistory(@PathVariable UUID memberId) {
        return ResponseEntity.ok(service.getChangeHistory(current.getCoachEmail(), memberId));
    }

    @PostMapping("/members/{memberId}/change-history")
    public ResponseEntity<ProgressPlannerChangeResponse> addChange(
            @PathVariable UUID memberId,
            @Valid @RequestBody ProgressPlannerChangeRequest request
    ) {
        return ResponseEntity.ok(service.addChange(current.getCoachEmail(), memberId, request));
    }

    @GetMapping("/progress-planner/work-queue")
    public ResponseEntity<List<ProgressPlannerWorkQueueRow>> workQueue() {
        return ResponseEntity.ok(service.getWorkQueue(current.getCoachEmail()));
    }

    @GetMapping("/members/progress-planner/work-queue")
    public ResponseEntity<List<ProgressPlannerWorkQueueRow>> memberRoutedWorkQueue() {
        return workQueue();
    }
}
