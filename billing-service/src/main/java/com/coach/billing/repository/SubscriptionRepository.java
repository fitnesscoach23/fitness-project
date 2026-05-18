package com.coach.billing.repository;

import com.coach.billing.entity.Subscription;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface SubscriptionRepository extends JpaRepository<Subscription, UUID> {
    List<Subscription> findByMemberIdOrderByStartDateDesc(UUID memberId);
    List<Subscription> findByMemberIdAndCoachEmailOrderByEndDateDesc(UUID memberId, String coachEmail);
}
