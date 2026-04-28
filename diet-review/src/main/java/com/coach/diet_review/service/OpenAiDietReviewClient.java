package com.coach.diet_review.service;

import com.coach.diet_review.config.OpenAiReviewProperties;
import com.coach.diet_review.dto.RowSuggestionDto;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestClient;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Component
@RequiredArgsConstructor
public class OpenAiDietReviewClient {

    private final RestClient openAiRestClient;
    private final OpenAiReviewProperties properties;
    private final ObjectMapper objectMapper;

    public Optional<GeneratedDietReview> review(DietReviewPrompt prompt) {
        if (!properties.enabled() || !StringUtils.hasText(properties.apiKey())) {
            return Optional.empty();
        }

        try {
            ObjectNode requestBody = buildRequestBody(prompt);
            JsonNode response = openAiRestClient.post()
                    .uri("/chat/completions")
                    .header(HttpHeaders.AUTHORIZATION, "Bearer " + properties.apiKey())
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(requestBody)
                    .retrieve()
                    .body(JsonNode.class);

            return extractReview(response);
        } catch (Exception ex) {
            log.warn("Falling back to rule-based diet review because OpenAI review failed: {}", ex.getMessage());
            return Optional.empty();
        }
    }

    private ObjectNode buildRequestBody(DietReviewPrompt prompt) {
        ObjectNode requestBody = objectMapper.createObjectNode();
        requestBody.put("model", properties.model());
        requestBody.put("temperature", properties.temperature());
        requestBody.put("max_completion_tokens", properties.maxOutputTokens());

        ArrayNode messages = requestBody.putArray("messages");
        messages.addObject()
                .put("role", "system")
                .put("content", properties.systemPrompt());
        messages.addObject()
                .put("role", "user")
                .put("content", prompt.userPrompt());

        ObjectNode responseFormat = requestBody.putObject("response_format");
        responseFormat.put("type", "json_object");

        return requestBody;
    }

    private Optional<GeneratedDietReview> extractReview(JsonNode response) {
        JsonNode contentNode = response.path("choices").path(0).path("message").path("content");
        if (!contentNode.isTextual()) {
            return Optional.empty();
        }

        JsonNode reviewNode;
        try {
            reviewNode = objectMapper.readTree(contentNode.asText());
        } catch (Exception ex) {
            return Optional.empty();
        }

        String summary = reviewNode.path("summary").asText(null);
        if (!StringUtils.hasText(summary)) {
            return Optional.empty();
        }

        List<String> suggestions = new ArrayList<>();
        reviewNode.path("suggestions").forEach(node -> {
            if (node.isTextual() && StringUtils.hasText(node.asText())) {
                suggestions.add(node.asText());
            }
        });

        List<RowSuggestionDto> rowSuggestions = new ArrayList<>();
        reviewNode.path("rowSuggestions").forEach(node -> {
            String mealType = node.path("mealType").asText(null);
            String foodName = node.path("foodName").asText(null);
            String suggestion = node.path("suggestion").asText(null);
            if (StringUtils.hasText(mealType) && StringUtils.hasText(foodName) && StringUtils.hasText(suggestion)) {
                rowSuggestions.add(new RowSuggestionDto(mealType, foodName, suggestion));
            }
        });

        return Optional.of(new GeneratedDietReview(summary, suggestions, rowSuggestions));
    }
}
