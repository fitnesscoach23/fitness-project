package com.coach.notification.provider;

public record NotificationSendResult(
        boolean success,
        String errorMessage,
        String providerMessageId
) {

    public static NotificationSendResult sent() {
        return new NotificationSendResult(true, null, null);
    }

    public static NotificationSendResult sent(String providerMessageId) {
        return new NotificationSendResult(true, null, providerMessageId);
    }

    public static NotificationSendResult failed(String errorMessage) {
        return new NotificationSendResult(false, errorMessage, null);
    }
}
