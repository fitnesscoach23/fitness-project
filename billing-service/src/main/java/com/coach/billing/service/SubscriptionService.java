package com.coach.billing.service;

import com.coach.billing.dto.CreateSubscriptionRequest;
import com.coach.billing.dto.SubscriptionResponse;
import com.coach.billing.entity.Subscription;
import com.coach.billing.entity.SubscriptionStatus;
import com.coach.billing.repository.SubscriptionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class SubscriptionService {

    private final SubscriptionRepository repo;

    public UUID create(String coachEmail, CreateSubscriptionRequest req) {
        Subscription sub = Subscription.builder()
                .memberId(req.memberId())
                .coachEmail(coachEmail)
                .startDate(req.startDate())
                .endDate(req.endDate())
                .status(SubscriptionStatus.ACTIVE)
                .createdAt(Instant.now())
                .build();

        repo.save(sub);
        return sub.getId();
    }

    public List<SubscriptionResponse> list(String coachEmail, UUID memberId) {
        return repo.findByMemberIdAndCoachEmailOrderByEndDateDesc(memberId, coachEmail)
                .stream()
                .map(s -> new SubscriptionResponse(
                        s.getId(),
                        s.getMemberId(),
                        s.getStartDate(),
                        s.getEndDate(),
                        s.getStatus().name()
                )).toList();
    }

    /**
     * Activates a new subscription or extends the latest active subscription by 1 month.
     * If no active subscription exists, create a new subscription.
     */
    public Subscription activateOrExtendSubscription(String coachEmail,
                                                     UUID memberId,
                                                     LocalDate startDate,
                                                     LocalDate endDate) {

        List<Subscription> list = repo.findByMemberIdAndCoachEmailOrderByEndDateDesc(memberId, coachEmail);
        Subscription latest = list.isEmpty() ? null : list.get(0);

        if (latest != null) {
            latest.setStatus(SubscriptionStatus.ACTIVE);
            // Keep the original subscription start date intact and calculate
            // the next renewal directly from the confirmed payment date.
            latest.setEndDate(endDate);
            repo.save(latest);
            return latest;
        }

        Subscription sub = Subscription.builder()
                .memberId(memberId)
                .coachEmail(coachEmail)
                .startDate(startDate)
                .endDate(endDate)
                .status(SubscriptionStatus.ACTIVE)
                .createdAt(Instant.now())
                .build();

        repo.save(sub);
        return sub;
    }

    public void resetLatestSubscriptionAfterPaymentDelete(String coachEmail,
                                                          UUID memberId,
                                                          LocalDate fallbackEndDate) {
        List<Subscription> list = repo.findByMemberIdAndCoachEmailOrderByEndDateDesc(memberId, coachEmail);
        if (list.isEmpty()) {
            return;
        }

        Subscription latest = list.get(0);
        LocalDate nextEndDate = fallbackEndDate != null
                ? fallbackEndDate
                : latest.getStartDate().plusMonths(1);

        latest.setEndDate(nextEndDate);
        latest.setStatus(nextEndDate.isBefore(LocalDate.now())
                ? SubscriptionStatus.EXPIRED
                : SubscriptionStatus.ACTIVE);
        repo.save(latest);
    }

    /**
     * Helper to automatically mark expired subscriptions.
     */
    public void evaluateExpiry() {
        List<Subscription> list = repo.findAll();

        for (Subscription sub : list) {
            if (sub.getStatus() == SubscriptionStatus.ACTIVE
                    && sub.getEndDate().isBefore(LocalDate.now())) {
                sub.setStatus(SubscriptionStatus.EXPIRED);
                repo.save(sub);
            }
        }
    }
}
