package com.coach.notification.dto;

import com.coach.notification.entity.NotificationChannel;
import com.coach.notification.entity.NotificationType;
import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.List;
import java.util.UUID;

public record SendNotificationRequest(
        @NotNull UUID memberId,
        @NotNull NotificationChannel channel,
        @NotNull NotificationType type,
        @NotBlank String recipient,
        String subject,
        @NotBlank String message,
        String imageDataUrl,
        String imageFileName,
        String documentDataUrl,
        String documentFileName,
        List<String> templateParameters
) {

    @AssertTrue(message = "Subject is required for EMAIL notifications")
    public boolean isSubjectValid() {
        return channel != NotificationChannel.EMAIL || (subject != null && !subject.trim().isEmpty());
    }
}
