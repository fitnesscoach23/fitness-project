package com.coach.diet_review.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "openai.review")
public record OpenAiReviewProperties(
        boolean enabled,
        String apiKey,
        String model,
        String baseUrl,
        double temperature,
        int maxOutputTokens,
        int timeoutMs,
        String systemPrompt
) {
}
