package com.coach.notification.provider;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "whatsapp")
public record WhatsAppProperties(
        String mode,
        String apiBaseUrl,
        String phoneNumberId,
        String accessToken,
        String templateName,
        String templateLanguageCode,
        String paymentReminderTemplateName,
        String checkinReminderTemplateName,
        String progressComparisonTemplateName,
        String consistencyReportTemplateName,
        String workoutPlanTemplateName,
        String dietPlanTemplateName
) {

    public boolean cloudMode() {
        return "cloud".equalsIgnoreCase(mode);
    }

    public boolean templateMode() {
        return hasText(templateName)
                || hasText(paymentReminderTemplateName)
                || hasText(checkinReminderTemplateName)
                || hasText(progressComparisonTemplateName)
                || hasText(consistencyReportTemplateName)
                || hasText(workoutPlanTemplateName)
                || hasText(dietPlanTemplateName);
    }

    private boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }
}
