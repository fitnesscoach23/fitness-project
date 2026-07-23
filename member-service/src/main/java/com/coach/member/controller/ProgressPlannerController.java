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

    @GetMapping("/members/{memberId}/recommendations")
    public ResponseEntity<List<ProgressPlannerRecommendationResponse>> recommendations(@PathVariable UUID memberId) {
        return ResponseEntity.ok(service.getRecommendations(current.getCoachEmail(), memberId));
    }

    @PostMapping("/members/{memberId}/recommendations/generate")
    public ResponseEntity<List<ProgressPlannerRecommendationResponse>> generateRecommendations(@PathVariable UUID memberId) {
        return ResponseEntity.ok(service.generateRecommendations(current.getCoachEmail(), memberId));
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

    @GetMapping("/members/dashboard/progress-planner-summary")
    public ResponseEntity<ProgressPlannerDashboardSummaryResponse> memberRoutedDashboardSummary() {
        return ResponseEntity.ok(service.getDashboardSummary(current.getCoachEmail()));
    }

    @GetMapping("/dashboard/progress-planner-summary")
    public ResponseEntity<ProgressPlannerDashboardSummaryResponse> dashboardSummary() {
        return memberRoutedDashboardSummary();
    }

    @PostMapping("/recommendations/{id}/accept")
    public ResponseEntity<ProgressPlannerRecommendationResponse> acceptRecommendation(
            @PathVariable UUID id,
            @Valid @RequestBody RecommendationDecisionRequest request
    ) {
        return ResponseEntity.ok(service.acceptRecommendation(current.getCoachEmail(), id, request));
    }

    @PostMapping("/recommendations/{id}/modify")
    public ResponseEntity<ProgressPlannerRecommendationResponse> modifyRecommendation(
            @PathVariable UUID id,
            @Valid @RequestBody RecommendationDecisionRequest request
    ) {
        return ResponseEntity.ok(service.modifyRecommendation(current.getCoachEmail(), id, request));
    }

    @PostMapping("/recommendations/{id}/reject")
    public ResponseEntity<ProgressPlannerRecommendationResponse> rejectRecommendation(
            @PathVariable UUID id,
            @Valid @RequestBody RecommendationDecisionRequest request
    ) {
        return ResponseEntity.ok(service.rejectRecommendation(current.getCoachEmail(), id, request));
    }

    @PostMapping("/recommendations/{id}/postpone")
    public ResponseEntity<ProgressPlannerRecommendationResponse> postponeRecommendation(
            @PathVariable UUID id,
            @Valid @RequestBody RecommendationDecisionRequest request
    ) {
        return ResponseEntity.ok(service.postponeRecommendation(current.getCoachEmail(), id, request));
    }

    @PostMapping("/members/recommendations/{id}/accept")
    public ResponseEntity<ProgressPlannerRecommendationResponse> memberRoutedAcceptRecommendation(
            @PathVariable UUID id,
            @Valid @RequestBody RecommendationDecisionRequest request
    ) {
        return acceptRecommendation(id, request);
    }

    @PostMapping("/members/recommendations/{id}/modify")
    public ResponseEntity<ProgressPlannerRecommendationResponse> memberRoutedModifyRecommendation(
            @PathVariable UUID id,
            @Valid @RequestBody RecommendationDecisionRequest request
    ) {
        return modifyRecommendation(id, request);
    }

    @PostMapping("/members/recommendations/{id}/reject")
    public ResponseEntity<ProgressPlannerRecommendationResponse> memberRoutedRejectRecommendation(
            @PathVariable UUID id,
            @Valid @RequestBody RecommendationDecisionRequest request
    ) {
        return rejectRecommendation(id, request);
    }

    @PostMapping("/members/recommendations/{id}/postpone")
    public ResponseEntity<ProgressPlannerRecommendationResponse> memberRoutedPostponeRecommendation(
            @PathVariable UUID id,
            @Valid @RequestBody RecommendationDecisionRequest request
    ) {
        return postponeRecommendation(id, request);
    }
}
