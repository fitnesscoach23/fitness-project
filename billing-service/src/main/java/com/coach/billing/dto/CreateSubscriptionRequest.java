package com.coach.billing.dto;

import java.time.LocalDate;
import java.util.UUID;

public record CreateSubscriptionRequest(
        UUID memberId,
        LocalDate startDate,
        LocalDate endDate
) {}
