package com.coach.billing.dto;

import java.time.LocalDate;
import java.util.UUID;

public record SubscriptionResponse(
        UUID id,
        UUID memberId,
        LocalDate startDate,
        LocalDate endDate,
        String status
) {}
