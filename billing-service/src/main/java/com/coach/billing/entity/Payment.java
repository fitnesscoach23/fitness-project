package com.coach.billing.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(name = "payments")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Payment {

    @Id
    @GeneratedValue
    @Column(nullable = false)
    private UUID id;

    @Column(name = "member_id", nullable = false)
    private UUID memberId;

    @Column(name = "coach_email", nullable = false)
    private String coachEmail;

    @Column(nullable = false)
    private BigDecimal amount;

    // Already made nullable in Phase-1 via V4 migration
    @Column(name = "payment_date")
    private LocalDate paymentDate;

    @Column(nullable = false)
    private String mode; // MANUAL, ONLINE

    @Column
    private String notes;

    @Column(nullable = false)
    private Instant createdAt;

    @Column(name = "deleted_at")
    private Instant deletedAt;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PaymentStatus status; // PENDING, SUCCESS, FAILED

    @Column(nullable = false)
    private String gateway; // MANUAL, RAZORPAY, STRIPE

    // ---------------------------
    // Razorpay / Gateway fields
    // ---------------------------

    @Column(name = "gateway_order_id")
    private String gatewayOrderId;

    @Column(name = "gateway_payment_id")
    private String gatewayPaymentId;

    @Column(name = "gateway_signature")
    private String gatewaySignature;
}
