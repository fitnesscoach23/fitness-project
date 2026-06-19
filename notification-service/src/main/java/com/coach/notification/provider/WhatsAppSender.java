package com.coach.notification.provider;

import com.coach.notification.entity.NotificationType;

public interface WhatsAppSender {

    NotificationSendResult send(
            String recipient,
            String message,
            String imageDataUrl,
            String imageFileName,
            String documentDataUrl,
            String documentFileName,
            NotificationType type,
            java.util.List<String> templateParameters
    );
}
