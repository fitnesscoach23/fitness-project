package com.coach.billing.repository;

import com.coach.billing.entity.Payment;
import com.coach.billing.entity.PaymentStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface PaymentRepository extends JpaRepository<Payment, UUID> {
    List<Payment> findByMemberIdAndDeletedAtIsNullOrderByPaymentDateDesc(UUID memberId);
    List<Payment> findByMemberIdAndDeletedAtIsNullOrderByCreatedAtDesc(UUID memberId);
    Optional<Payment> findByIdAndDeletedAtIsNull(UUID id);
    Optional<Payment> findByIdAndCoachEmailAndDeletedAtIsNull(UUID id, String coachEmail);
    Optional<Payment> findByGatewayOrderIdAndDeletedAtIsNull(String gatewayOrderId);
    List<Payment> findByMemberIdAndCoachEmailAndStatusAndDeletedAtIsNullOrderByPaymentDateDesc(
            UUID memberId,
            String coachEmail,
            PaymentStatus status
    );
}
