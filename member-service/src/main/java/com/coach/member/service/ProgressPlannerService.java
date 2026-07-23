package com.coach.member.service;

import com.coach.member.dto.*;
import com.coach.member.entity.*;
import com.coach.member.repository.CoachingPhaseRepository;
import com.coach.member.repository.MemberRepository;
import com.coach.member.repository.ProgressPlannerChangeRepository;
import com.coach.member.repository.ProgressPlannerRecommendationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.time.Instant;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProgressPlannerService {

    private static final List<CoachingPhaseStatus> CURRENT_STATUSES = List.of(
            CoachingPhaseStatus.ACTIVE,
            CoachingPhaseStatus.REVIEW_SOON,
            CoachingPhaseStatus.CHANGE_RECOMMENDED
    );

    private final MemberRepository memberRepository;
    private final CoachingPhaseRepository phaseRepository;
    private final ProgressPlannerChangeRepository changeRepository;
    private final ProgressPlannerRecommendationRepository recommendationRepository;
    private final ProgressRecommendationRuleService recommendationRuleService;

    @Transactional(readOnly = true)
    public ProgressPlannerOverviewResponse getOverview(String coachEmail, UUID memberId) {
        requireMember(coachEmail, memberId);
        List<CoachingPhaseResponse> phases = phaseRepository
                .findByCoachEmailAndMemberIdOrderByPhaseNumberAscStartDateAsc(coachEmail, memberId)
                .stream()
                .map(this::toPhaseResponse)
                .toList();
        CoachingPhaseResponse currentPhase = phaseRepository
                .findFirstByCoachEmailAndMemberIdAndStatusInOrderByStartDateDesc(coachEmail, memberId, CURRENT_STATUSES)
                .map(this::toPhaseResponse)
                .orElse(null);

        return new ProgressPlannerOverviewResponse(
                currentPhase,
                phases,
                getChangeHistory(coachEmail, memberId),
                getRecommendations(coachEmail, memberId)
        );
    }

    @Transactional(readOnly = true)
    public List<ProgressPlannerRecommendationResponse> getRecommendations(String coachEmail, UUID memberId) {
        requireMember(coachEmail, memberId);
        return recommendationRepository.findByCoachEmailAndMemberIdOrderByGeneratedAtDesc(coachEmail, memberId)
                .stream()
                .map(this::toRecommendationResponse)
                .toList();
    }

    @Transactional
    public List<ProgressPlannerRecommendationResponse> generateRecommendations(String coachEmail, UUID memberId) {
        Member member = requireMember(coachEmail, memberId);
        CoachingPhase phase = phaseRepository
                .findFirstByCoachEmailAndMemberIdAndStatusInOrderByStartDateDesc(coachEmail, memberId, CURRENT_STATUSES)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.BAD_REQUEST, "Start an active phase before generating recommendations"));

        List<ProgressRecommendationStatus> openStatuses = List.of(ProgressRecommendationStatus.NEW, ProgressRecommendationStatus.POSTPONED);
        List<ProgressPlannerRecommendation> generated = recommendationRuleService.generate(member, phase)
                .stream()
                .filter(candidate -> recommendationRepository
                        .findFirstByCoachEmailAndMemberIdAndPhaseIdAndRecommendationTypeAndStatusIn(
                                coachEmail,
                                memberId,
                                phase.getId(),
                                candidate.getRecommendationType(),
                                openStatuses
                        )
                        .isEmpty()
                )
                .map(recommendationRepository::save)
                .toList();

        if (!generated.isEmpty() && phase.getStatus() == CoachingPhaseStatus.ACTIVE) {
            phase.setStatus(CoachingPhaseStatus.CHANGE_RECOMMENDED);
            phase.setUpdatedAt(Instant.now());
            phaseRepository.save(phase);
        }

        return getRecommendations(coachEmail, memberId);
    }

    @Transactional
    public ProgressPlannerRecommendationResponse acceptRecommendation(
            String coachEmail,
            UUID recommendationId,
            RecommendationDecisionRequest request
    ) {
        ProgressPlannerRecommendation recommendation = requireRecommendation(coachEmail, recommendationId);
        recommendation.setStatus(ProgressRecommendationStatus.ACCEPTED);
        recommendation.setReviewedAt(Instant.now());
        recommendation.setCoachDecisionNotes(request.coachDecisionNotes());
        ProgressPlannerRecommendation saved = recommendationRepository.save(recommendation);

        createChange(
                coachEmail,
                saved.getMemberId(),
                saved.getPhaseId(),
                parseChangeType(saved.getAcceptanceChangeType()),
                LocalDate.now(),
                null,
                firstText(request.suggestedAction(), saved.getSuggestedAction()),
                "Recommendation accepted: " + saved.getReason(),
                request.coachDecisionNotes(),
                ProgressPlannerChangeSource.RECOMMENDATION_ACCEPTED
        );

        return toRecommendationResponse(saved);
    }

    @Transactional
    public ProgressPlannerRecommendationResponse modifyRecommendation(
            String coachEmail,
            UUID recommendationId,
            RecommendationDecisionRequest request
    ) {
        ProgressPlannerRecommendation recommendation = requireRecommendation(coachEmail, recommendationId);
        recommendation.setStatus(ProgressRecommendationStatus.MODIFIED);
        recommendation.setSuggestedAction(firstText(request.suggestedAction(), recommendation.getSuggestedAction()));
        recommendation.setReviewedAt(Instant.now());
        recommendation.setCoachDecisionNotes(request.coachDecisionNotes());
        return toRecommendationResponse(recommendationRepository.save(recommendation));
    }

    @Transactional
    public ProgressPlannerRecommendationResponse rejectRecommendation(
            String coachEmail,
            UUID recommendationId,
            RecommendationDecisionRequest request
    ) {
        ProgressPlannerRecommendation recommendation = requireRecommendation(coachEmail, recommendationId);
        recommendation.setStatus(ProgressRecommendationStatus.REJECTED);
        recommendation.setReviewedAt(Instant.now());
        recommendation.setCoachDecisionNotes(request.coachDecisionNotes());
        return toRecommendationResponse(recommendationRepository.save(recommendation));
    }

    @Transactional
    public ProgressPlannerRecommendationResponse postponeRecommendation(
            String coachEmail,
            UUID recommendationId,
            RecommendationDecisionRequest request
    ) {
        ProgressPlannerRecommendation recommendation = requireRecommendation(coachEmail, recommendationId);
        recommendation.setStatus(ProgressRecommendationStatus.POSTPONED);
        recommendation.setReviewedAt(Instant.now());
        recommendation.setCoachDecisionNotes(request.coachDecisionNotes());
        return toRecommendationResponse(recommendationRepository.save(recommendation));
    }

    @Transactional(readOnly = true)
    public List<CoachingPhaseResponse> getPhases(String coachEmail, UUID memberId) {
        requireMember(coachEmail, memberId);
        return phaseRepository.findByCoachEmailAndMemberIdOrderByPhaseNumberAscStartDateAsc(coachEmail, memberId)
                .stream()
                .map(this::toPhaseResponse)
                .toList();
    }

    @Transactional
    public CoachingPhaseResponse createPhase(String coachEmail, UUID memberId, CoachingPhaseRequest request) {
        requireMember(coachEmail, memberId);
        CoachingPhaseStatus status = request.status() == null ? CoachingPhaseStatus.ACTIVE : request.status();
        if (status == CoachingPhaseStatus.ACTIVE) {
            closeCurrentPhases(coachEmail, memberId, request.startDate(), "New active phase started");
        }

        Instant now = Instant.now();
        CoachingPhase phase = CoachingPhase.builder()
                .memberId(memberId)
                .coachEmail(coachEmail)
                .phaseNumber(request.phaseNumber() == null
                        ? phaseRepository.findMaxPhaseNumber(coachEmail, memberId) + 1
                        : request.phaseNumber())
                .createdAt(now)
                .updatedAt(now)
                .build();

        applyRequest(phase, request, status);
        CoachingPhase saved = phaseRepository.save(phase);
        createChange(coachEmail, memberId, saved.getId(), ProgressPlannerChangeType.PHASE_STARTED,
                saved.getStartDate(), null, saved.getPhaseName(), request.coachReason(),
                request.phaseNotes(), ProgressPlannerChangeSource.MANUAL);

        return toPhaseResponse(saved);
    }

    @Transactional
    public CoachingPhaseResponse updatePhase(String coachEmail, UUID memberId, UUID phaseId, CoachingPhaseRequest request) {
        requireMember(coachEmail, memberId);
        CoachingPhase phase = requirePhase(coachEmail, memberId, phaseId);
        String previousSummary = summarizePhase(phase);
        CoachingPhaseStatus status = request.status() == null ? phase.getStatus() : request.status();
        if (status == CoachingPhaseStatus.ACTIVE && phase.getStatus() != CoachingPhaseStatus.ACTIVE) {
            closeCurrentPhases(coachEmail, memberId, request.startDate(), "Phase reactivated");
        }

        applyRequest(phase, request, status);
        phase.setUpdatedAt(Instant.now());
        CoachingPhase saved = phaseRepository.save(phase);

        createChange(coachEmail, memberId, saved.getId(), ProgressPlannerChangeType.PHASE_UPDATED,
                LocalDate.now(), previousSummary, summarizePhase(saved), request.coachReason(),
                request.phaseNotes(), ProgressPlannerChangeSource.MANUAL);

        return toPhaseResponse(saved);
    }

    @Transactional
    public CoachingPhaseResponse completePhase(String coachEmail, UUID memberId, UUID phaseId, PhaseLifecycleRequest request) {
        return transitionPhase(coachEmail, memberId, phaseId, request, CoachingPhaseStatus.COMPLETED,
                ProgressPlannerChangeType.PHASE_COMPLETED);
    }

    @Transactional
    public CoachingPhaseResponse pausePhase(String coachEmail, UUID memberId, UUID phaseId, PhaseLifecycleRequest request) {
        return transitionPhase(coachEmail, memberId, phaseId, request, CoachingPhaseStatus.PAUSED,
                ProgressPlannerChangeType.PHASE_PAUSED);
    }

    @Transactional
    public ProgressPlannerChangeResponse addChange(String coachEmail, UUID memberId, ProgressPlannerChangeRequest request) {
        requireMember(coachEmail, memberId);
        if (request.phaseId() != null) {
            requirePhase(coachEmail, memberId, request.phaseId());
        }
        return toChangeResponse(createChange(coachEmail, memberId, request.phaseId(), request.changeType(),
                request.changeDate() == null ? LocalDate.now() : request.changeDate(),
                request.previousValue(), request.newValue(), request.reason(), request.coachNotes(),
                request.source() == null ? ProgressPlannerChangeSource.MANUAL : request.source()));
    }

    @Transactional(readOnly = true)
    public List<ProgressPlannerChangeResponse> getChangeHistory(String coachEmail, UUID memberId) {
        requireMember(coachEmail, memberId);
        return changeRepository.findByCoachEmailAndMemberIdOrderByChangeDateDescCreatedAtDesc(coachEmail, memberId)
                .stream()
                .map(this::toChangeResponse)
                .toList();
    }

    @Transactional(readOnly = true)
    public List<ProgressPlannerWorkQueueRow> getWorkQueue(String coachEmail) {
        LocalDate today = LocalDate.now();
        List<CoachingPhase> phases = phaseRepository
                .findByCoachEmailAndStatusInOrderByPlannedEndDateAscStartDateAsc(coachEmail, CURRENT_STATUSES);
        Map<UUID, ProgressPlannerRecommendation> recommendationsByPhase = recommendationRepository
                .findByCoachEmailAndStatusInOrderByPriorityDescGeneratedAtDesc(
                        coachEmail,
                        List.of(ProgressRecommendationStatus.NEW, ProgressRecommendationStatus.POSTPONED)
                )
                .stream()
                .filter(recommendation -> recommendation.getPhaseId() != null)
                .collect(Collectors.toMap(
                        ProgressPlannerRecommendation::getPhaseId,
                        recommendation -> recommendation,
                        (first, second) -> first
                ));
        Map<UUID, Member> members = memberRepository.findAllById(
                        phases.stream().map(CoachingPhase::getMemberId).collect(Collectors.toSet())
                )
                .stream()
                .filter(member -> coachEmail.equals(member.getCoachEmail()))
                .collect(Collectors.toMap(Member::getId, member -> member));

        return phases.stream()
                .filter(phase -> members.containsKey(phase.getMemberId()))
                .map(phase -> {
                    Member member = members.get(phase.getMemberId());
                    ProgressPlannerRecommendation recommendation = recommendationsByPhase.get(phase.getId());
                    return new ProgressPlannerWorkQueueRow(
                            member.getId(),
                            member.getFullName(),
                            firstText(phase.getGoal(), member.getMainTrainingGoal(), member.getGoal()),
                            phase.getId(),
                            phase.getPhaseName(),
                            calculateCurrentWeek(phase),
                            "Not connected",
                            null,
                            recommendation == null ? "Phase Review" : getRecommendationTypeLabel(recommendation.getRecommendationType()),
                            recommendation == null ? (isOverdue(phase, today) ? "HIGH" : "MEDIUM") : recommendation.getPriority().name(),
                            phase.getPlannedEndDate(),
                            phase.getStatus(),
                            isOverdue(phase, today)
                    );
                })
                .toList();
    }

    @Transactional(readOnly = true)
    public ProgressPlannerDashboardSummaryResponse getDashboardSummary(String coachEmail) {
        List<ProgressPlannerWorkQueueRow> rows = getWorkQueue(coachEmail);
        List<ProgressPlannerRecommendation> recommendations = recommendationRepository
                .findByCoachEmailAndStatusInOrderByPriorityDescGeneratedAtDesc(
                        coachEmail,
                        List.of(ProgressRecommendationStatus.NEW, ProgressRecommendationStatus.POSTPONED)
                );

        return new ProgressPlannerDashboardSummaryResponse(
                rows.stream().filter(row -> "Phase Review".equals(row.recommendationType())).count(),
                countType(recommendations, ProgressRecommendationType.WORKOUT),
                countType(recommendations, ProgressRecommendationType.DIET),
                countType(recommendations, ProgressRecommendationType.STEPS),
                countType(recommendations, ProgressRecommendationType.RECOVERY),
                countType(recommendations, ProgressRecommendationType.NO_CHANGE),
                rows.stream().filter(ProgressPlannerWorkQueueRow::overdue).count()
        );
    }

    private CoachingPhaseResponse transitionPhase(
            String coachEmail,
            UUID memberId,
            UUID phaseId,
            PhaseLifecycleRequest request,
            CoachingPhaseStatus status,
            ProgressPlannerChangeType changeType
    ) {
        requireMember(coachEmail, memberId);
        CoachingPhase phase = requirePhase(coachEmail, memberId, phaseId);
        CoachingPhaseStatus previousStatus = phase.getStatus();
        LocalDate actionDate = request.actionDate() == null ? LocalDate.now() : request.actionDate();
        phase.setStatus(status);
        phase.setActualEndDate(actionDate);
        phase.setUpdatedAt(Instant.now());
        CoachingPhase saved = phaseRepository.save(phase);

        createChange(coachEmail, memberId, saved.getId(), changeType, actionDate,
                previousStatus.name(), status.name(), request.reason(), request.coachNotes(), ProgressPlannerChangeSource.MANUAL);

        return toPhaseResponse(saved);
    }

    private void closeCurrentPhases(String coachEmail, UUID memberId, LocalDate actionDate, String reason) {
        phaseRepository.findByCoachEmailAndMemberIdAndStatusIn(coachEmail, memberId, CURRENT_STATUSES)
                .forEach(active -> {
                    active.setStatus(CoachingPhaseStatus.COMPLETED);
                    active.setActualEndDate(actionDate);
                    active.setUpdatedAt(Instant.now());
                    phaseRepository.save(active);
                    createChange(coachEmail, memberId, active.getId(), ProgressPlannerChangeType.PHASE_COMPLETED,
                            actionDate, active.getPhaseName(), "Completed before next active phase", reason,
                            null, ProgressPlannerChangeSource.MANUAL);
                });
    }

    private ProgressPlannerChange createChange(
            String coachEmail,
            UUID memberId,
            UUID phaseId,
            ProgressPlannerChangeType type,
            LocalDate date,
            String previousValue,
            String newValue,
            String reason,
            String coachNotes,
            ProgressPlannerChangeSource source
    ) {
        return changeRepository.save(ProgressPlannerChange.builder()
                .memberId(memberId)
                .coachEmail(coachEmail)
                .phaseId(phaseId)
                .changeType(type)
                .changeDate(date)
                .previousValue(previousValue)
                .newValue(newValue)
                .reason(reason)
                .coachNotes(coachNotes)
                .source(source)
                .createdBy(coachEmail)
                .createdAt(Instant.now())
                .build());
    }

    private void applyRequest(CoachingPhase phase, CoachingPhaseRequest request, CoachingPhaseStatus status) {
        phase.setPhaseName(request.phaseName().trim());
        phase.setGoal(request.goal());
        phase.setStartDate(request.startDate());
        phase.setPlannedEndDate(request.plannedEndDate());
        phase.setStatus(status);
        phase.setWorkoutPlanId(request.workoutPlanId());
        phase.setDietPlanId(request.dietPlanId());
        phase.setCalorieTarget(request.calorieTarget());
        phase.setProteinTarget(request.proteinTarget());
        phase.setCarbTarget(request.carbTarget());
        phase.setFatTarget(request.fatTarget());
        phase.setStepTarget(request.stepTarget());
        phase.setPlannedWorkoutDays(request.plannedWorkoutDays());
        phase.setPhaseNotes(request.phaseNotes());
        phase.setCoachReason(request.coachReason());
    }

    private Member requireMember(String coachEmail, UUID memberId) {
        return memberRepository.findById(memberId)
                .filter(member -> coachEmail.equals(member.getCoachEmail()))
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Member not found"));
    }

    private CoachingPhase requirePhase(String coachEmail, UUID memberId, UUID phaseId) {
        return phaseRepository.findById(phaseId)
                .filter(phase -> coachEmail.equals(phase.getCoachEmail()) && memberId.equals(phase.getMemberId()))
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Coaching phase not found"));
    }

    private ProgressPlannerRecommendation requireRecommendation(String coachEmail, UUID recommendationId) {
        return recommendationRepository.findById(recommendationId)
                .filter(recommendation -> coachEmail.equals(recommendation.getCoachEmail()))
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Recommendation not found"));
    }

    private CoachingPhaseResponse toPhaseResponse(CoachingPhase phase) {
        LocalDate today = LocalDate.now();
        return new CoachingPhaseResponse(
                phase.getId(),
                phase.getMemberId(),
                phase.getPhaseNumber(),
                phase.getPhaseName(),
                phase.getGoal(),
                phase.getStartDate(),
                phase.getPlannedEndDate(),
                phase.getActualEndDate(),
                phase.getStatus(),
                phase.getWorkoutPlanId(),
                phase.getDietPlanId(),
                phase.getCalorieTarget(),
                phase.getProteinTarget(),
                phase.getCarbTarget(),
                phase.getFatTarget(),
                phase.getStepTarget(),
                phase.getPlannedWorkoutDays(),
                phase.getPhaseNotes(),
                phase.getCoachReason(),
                Math.max(1, ChronoUnit.DAYS.between(phase.getStartDate(), today) + 1),
                calculateCurrentWeek(phase),
                isOverdue(phase, today),
                phase.getCreatedAt(),
                phase.getUpdatedAt()
        );
    }

    private ProgressPlannerChangeResponse toChangeResponse(ProgressPlannerChange change) {
        return new ProgressPlannerChangeResponse(
                change.getId(),
                change.getMemberId(),
                change.getPhaseId(),
                change.getChangeType(),
                change.getChangeDate(),
                change.getPreviousValue(),
                change.getNewValue(),
                change.getReason(),
                change.getCoachNotes(),
                change.getSource(),
                change.getCreatedBy(),
                change.getCreatedAt()
        );
    }

    private ProgressPlannerRecommendationResponse toRecommendationResponse(ProgressPlannerRecommendation recommendation) {
        return new ProgressPlannerRecommendationResponse(
                recommendation.getId(),
                recommendation.getMemberId(),
                recommendation.getPhaseId(),
                recommendation.getRecommendationType(),
                recommendation.getTitle(),
                recommendation.getSuggestedAction(),
                recommendation.getReason(),
                recommendation.getSupportingMetrics(),
                recommendation.getPriority(),
                recommendation.getStatus(),
                recommendation.getGeneratedAt(),
                recommendation.getReviewedAt(),
                recommendation.getCoachDecisionNotes()
        );
    }

    private long calculateCurrentWeek(CoachingPhase phase) {
        return Math.max(1, (ChronoUnit.DAYS.between(phase.getStartDate(), LocalDate.now()) / 7) + 1);
    }

    private boolean isOverdue(CoachingPhase phase, LocalDate today) {
        return phase.getPlannedEndDate() != null
                && phase.getPlannedEndDate().isBefore(today)
                && phase.getStatus() != CoachingPhaseStatus.COMPLETED
                && phase.getStatus() != CoachingPhaseStatus.PAUSED;
    }

    private String summarizePhase(CoachingPhase phase) {
        return "%s | %s | calories=%s | steps=%s | status=%s".formatted(
                phase.getPhaseName(),
                firstText(phase.getGoal(), "No goal"),
                phase.getCalorieTarget() == null ? "-" : phase.getCalorieTarget(),
                phase.getStepTarget() == null ? "-" : phase.getStepTarget(),
                phase.getStatus()
        );
    }

    private String firstText(String... values) {
        for (String value : values) {
            if (value != null && !value.isBlank()) {
                return value;
            }
        }
        return "-";
    }

    private ProgressPlannerChangeType parseChangeType(String value) {
        try {
            return ProgressPlannerChangeType.valueOf(firstText(value, "OTHER"));
        } catch (IllegalArgumentException ex) {
            return ProgressPlannerChangeType.OTHER;
        }
    }

    private String getRecommendationTypeLabel(ProgressRecommendationType type) {
        if (type == ProgressRecommendationType.NO_CHANGE) return "No Change Required";
        if (type == ProgressRecommendationType.PHASE_REVIEW) return "Phase Review";
        return type.name().charAt(0) + type.name().substring(1).toLowerCase();
    }

    private long countType(List<ProgressPlannerRecommendation> recommendations, ProgressRecommendationType type) {
        return recommendations.stream()
                .filter(recommendation -> recommendation.getRecommendationType() == type)
                .count();
    }
}
