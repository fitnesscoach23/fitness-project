package com.coach.notification.provider;

import com.coach.notification.entity.NotificationType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestClientResponseException;

import java.util.Base64;
import java.util.List;
import java.util.Map;

@Component
@Slf4j
@RequiredArgsConstructor
public class WhatsAppSenderImpl implements WhatsAppSender {

    private final WhatsAppProperties properties;

    @Override
    public NotificationSendResult send(
            String recipient,
            String message,
            String imageDataUrl,
            String imageFileName,
            String documentDataUrl,
            String documentFileName,
            NotificationType type,
            List<String> templateParameters
    ) {
        if (shouldFail(recipient, message)) {
            return NotificationSendResult.failed("Mock WhatsApp provider failure");
        }

        if (!properties.cloudMode()) {
            log.info(
                    "Mock WhatsApp send triggered for recipient={}, type={}, hasImage={}, hasDocument={}",
                    recipient,
                    type,
                    StringUtils.hasText(imageDataUrl),
                    StringUtils.hasText(documentDataUrl)
            );
            return NotificationSendResult.sent();
        }

        if (!hasCloudConfig()) {
            return NotificationSendResult.failed("WhatsApp Cloud API config is incomplete");
        }

        try {
            RestClient client = RestClient.create(properties.apiBaseUrl());
            Map<?, ?> response;
            if (shouldSendTemplate(type)) {
                response = sendTemplate(client, recipient, message, imageDataUrl, imageFileName, documentDataUrl, documentFileName, type, templateParameters);
            } else {
                response = StringUtils.hasText(documentDataUrl)
                        ? sendDocument(client, recipient, message, documentDataUrl, documentFileName)
                        : StringUtils.hasText(imageDataUrl)
                        ? sendImage(client, recipient, message, imageDataUrl, imageFileName)
                        : sendText(client, recipient, message);
            }

            return NotificationSendResult.sent(extractProviderMessageId(response));
        } catch (RestClientException | IllegalArgumentException ex) {
            String errorMessage = getProviderErrorMessage(ex);
            log.warn("WhatsApp Cloud API send failed for recipient={}, error={}", recipient, errorMessage, ex);
            return NotificationSendResult.failed(errorMessage);
        }
    }

    private Map<?, ?> sendText(RestClient client, String recipient, String message) {
        return client.post()
                .uri("/{phoneNumberId}/messages", properties.phoneNumberId())
                .contentType(MediaType.APPLICATION_JSON)
                .headers(headers -> headers.setBearerAuth(properties.accessToken()))
                .body(Map.of(
                        "messaging_product", "whatsapp",
                        "recipient_type", "individual",
                        "to", normalizePhone(recipient),
                        "type", "text",
                        "text", Map.of(
                                "preview_url", false,
                                "body", message
                        )
                ))
                .retrieve()
                .body(Map.class);
    }

    private Map<?, ?> sendTemplate(
            RestClient client,
            String recipient,
            String message,
            String imageDataUrl,
            String imageFileName,
            String documentDataUrl,
            String documentFileName,
            NotificationType type,
            List<String> templateParameters
    ) {
        List<Map<String, Object>> components = new java.util.ArrayList<>();
        String templateName = selectTemplateName(type);

        if (!StringUtils.hasText(templateName)) {
            throw new RestClientException("No WhatsApp template configured for notification type " + type);
        }

        if (requiresImageHeader(type) && !StringUtils.hasText(imageDataUrl)) {
            throw new RestClientException("WhatsApp template " + templateName + " requires an image header, but no image was provided");
        }

        if (type == NotificationType.WORKOUT_PLAN && !StringUtils.hasText(documentDataUrl)) {
            throw new RestClientException("WhatsApp template " + templateName + " requires a document header, but no document was provided");
        }

        if (StringUtils.hasText(documentDataUrl)) {
            UploadedMedia document = parseDocumentDataUrl(documentDataUrl, documentFileName);
            String mediaId = uploadMedia(client, document);
            components.add(Map.of(
                    "type", "header",
                    "parameters", List.of(Map.of(
                            "type", "document",
                            "document", Map.of(
                                    "id", mediaId,
                                    "filename", document.fileName()
                            )
                    ))
            ));
        } else if (StringUtils.hasText(imageDataUrl)) {
            UploadedMedia image = parseImageDataUrl(imageDataUrl, imageFileName);
            String mediaId = uploadMedia(client, image);
            components.add(Map.of(
                    "type", "header",
                    "parameters", List.of(Map.of(
                            "type", "image",
                            "image", Map.of("id", mediaId)
                    ))
            ));
        }

        components.add(Map.of(
                "type", "body",
                "parameters", buildBodyParameters(message, templateParameters, type)
        ));

        return client.post()
                .uri("/{phoneNumberId}/messages", properties.phoneNumberId())
                .contentType(MediaType.APPLICATION_JSON)
                .headers(headers -> headers.setBearerAuth(properties.accessToken()))
                .body(Map.of(
                        "messaging_product", "whatsapp",
                        "recipient_type", "individual",
                        "to", normalizePhone(recipient),
                        "type", "template",
                        "template", Map.of(
                                "name", templateName.trim(),
                                "language", Map.of("code", getTemplateLanguageCode()),
                                "components", components
                        )
                ))
                .retrieve()
                .body(Map.class);
    }

    private Map<?, ?> sendImage(
            RestClient client,
            String recipient,
            String message,
            String imageDataUrl,
            String imageFileName
    ) {
        UploadedMedia image = parseImageDataUrl(imageDataUrl, imageFileName);
        String mediaId = uploadMedia(client, image);

        return client.post()
                .uri("/{phoneNumberId}/messages", properties.phoneNumberId())
                .contentType(MediaType.APPLICATION_JSON)
                .headers(headers -> headers.setBearerAuth(properties.accessToken()))
                .body(Map.of(
                        "messaging_product", "whatsapp",
                        "recipient_type", "individual",
                        "to", normalizePhone(recipient),
                        "type", "image",
                        "image", Map.of(
                                "id", mediaId,
                                "caption", message
                        )
                ))
                .retrieve()
                .body(Map.class);
    }

    private Map<?, ?> sendDocument(
            RestClient client,
            String recipient,
            String message,
            String documentDataUrl,
            String documentFileName
    ) {
        UploadedMedia document = parseDocumentDataUrl(documentDataUrl, documentFileName);
        String mediaId = uploadMedia(client, document);

        return client.post()
                .uri("/{phoneNumberId}/messages", properties.phoneNumberId())
                .contentType(MediaType.APPLICATION_JSON)
                .headers(headers -> headers.setBearerAuth(properties.accessToken()))
                .body(Map.of(
                        "messaging_product", "whatsapp",
                        "recipient_type", "individual",
                        "to", normalizePhone(recipient),
                        "type", "document",
                        "document", Map.of(
                                "id", mediaId,
                                "filename", document.fileName(),
                                "caption", message
                        )
                ))
                .retrieve()
                .body(Map.class);
    }

    private String uploadMedia(RestClient client, UploadedMedia media) {
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("messaging_product", "whatsapp");
        body.add("type", media.contentType());
        body.add("file", buildFilePart(media));

        Map<?, ?> response = client.post()
                .uri("/{phoneNumberId}/media", properties.phoneNumberId())
                .contentType(MediaType.MULTIPART_FORM_DATA)
                .headers(headers -> headers.setBearerAuth(properties.accessToken()))
                .body(body)
                .retrieve()
                .body(Map.class);

        Object id = response == null ? null : response.get("id");
        if (id == null || !StringUtils.hasText(id.toString())) {
            throw new RestClientException("WhatsApp media upload did not return a media id");
        }
        return id.toString();
    }

    private HttpEntity<ByteArrayResource> buildFilePart(UploadedMedia media) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType(media.contentType()));

        ByteArrayResource resource = new ByteArrayResource(media.bytes()) {
            @Override
            public String getFilename() {
                return media.fileName();
            }
        };

        return new HttpEntity<>(resource, headers);
    }

    private UploadedMedia parseImageDataUrl(String imageDataUrl, String imageFileName) {
        String[] parts = imageDataUrl.split(",", 2);
        if (parts.length != 2 || !parts[0].startsWith("data:image/")) {
            throw new RestClientException("WhatsApp image must be a data URL");
        }

        String contentType = parts[0]
                .replace("data:", "")
                .replace(";base64", "");
        byte[] bytes = Base64.getDecoder().decode(parts[1]);
        String fileName = StringUtils.hasText(imageFileName) ? imageFileName : "whatsapp-image.png";

        return new UploadedMedia(contentType, fileName, bytes);
    }

    private UploadedMedia parseDocumentDataUrl(String documentDataUrl, String documentFileName) {
        String[] parts = documentDataUrl.split(",", 2);
        if (parts.length != 2 || !parts[0].startsWith("data:")) {
            throw new RestClientException("WhatsApp document must be a data URL");
        }

        String contentType = parts[0]
                .replace("data:", "")
                .replace(";base64", "");
        byte[] bytes = Base64.getDecoder().decode(parts[1]);
        String fileName = StringUtils.hasText(documentFileName) ? documentFileName : "workout-plan.xlsx";

        return new UploadedMedia(contentType, fileName, bytes);
    }

    private boolean hasCloudConfig() {
        return StringUtils.hasText(properties.apiBaseUrl())
                && StringUtils.hasText(properties.phoneNumberId())
                && StringUtils.hasText(properties.accessToken());
    }

    private String normalizePhone(String value) {
        return value == null ? "" : value.replaceAll("[^0-9]", "");
    }

    private String getTemplateLanguageCode() {
        return StringUtils.hasText(properties.templateLanguageCode())
                ? properties.templateLanguageCode().trim()
                : "en_US";
    }

    private boolean shouldSendTemplate(NotificationType type) {
        if (type == NotificationType.DIET_PLAN) {
            return false;
        }

        return properties.templateMode();
    }

    private List<Map<String, Object>> buildBodyParameters(
            String message,
            List<String> templateParameters,
            NotificationType type
    ) {
        List<String> values = templateParameters == null || templateParameters.isEmpty()
                ? List.of(message)
                : templateParameters;

        return values.stream()
                .map(value -> sanitizeTemplateText(value, type))
                .map(text -> Map.<String, Object>of(
                        "type", "text",
                        "text", text
                ))
                .toList();
    }

    private String selectTemplateName(NotificationType type) {
        return switch (type) {
            case PAYMENT_REMINDER -> firstText(properties.paymentReminderTemplateName(), properties.templateName());
            case CHECKIN_REMINDER -> firstText(properties.checkinReminderTemplateName(), properties.templateName());
            case PROGRESS_COMPARISON -> firstText(properties.progressComparisonTemplateName(), properties.templateName());
            case WEEKLY_CONSISTENCY_REPORT -> firstText(properties.consistencyReportTemplateName(), properties.templateName());
            case WORKOUT_PLAN -> firstText(properties.workoutPlanTemplateName(), properties.templateName());
            case DIET_PLAN -> firstText(properties.dietPlanTemplateName(), properties.templateName());
            default -> properties.templateName();
        };
    }

    private boolean requiresImageHeader(NotificationType type) {
        return type == NotificationType.PAYMENT_REMINDER
                || type == NotificationType.CHECKIN_REMINDER
                || type == NotificationType.PROGRESS_COMPARISON
                || type == NotificationType.WEEKLY_CONSISTENCY_REPORT;
    }

    private String firstText(String primary, String fallback) {
        return StringUtils.hasText(primary) ? primary : fallback;
    }

    private String sanitizeTemplateText(String value, NotificationType type) {
        if (!StringUtils.hasText(value)) {
            return "-";
        }

        return value
                .replaceAll("[\\r\\n\\t]+", " ")
                .replaceAll(" {2,}", " ")
                .trim();
    }

    private String extractProviderMessageId(Map<?, ?> response) {
        Object messages = response == null ? null : response.get("messages");
        if (!(messages instanceof List<?> list) || list.isEmpty()) {
            return null;
        }

        Object first = list.get(0);
        if (!(first instanceof Map<?, ?> firstMessage)) {
            return null;
        }

        Object id = firstMessage.get("id");
        return id == null ? null : id.toString();
    }

    private boolean shouldFail(String recipient, String message) {
        return containsFailureToken(recipient) || containsFailureToken(message);
    }

    private boolean containsFailureToken(String value) {
        return value != null && value.toLowerCase().contains("fail");
    }

    private String getProviderErrorMessage(Exception ex) {
        if (ex instanceof RestClientResponseException responseException) {
            String body = responseException.getResponseBodyAsString();
            if (StringUtils.hasText(body)) {
                return "WhatsApp Cloud API error: " + body;
            }
        }

        return ex.getMessage();
    }

    private record UploadedMedia(String contentType, String fileName, byte[] bytes) {
    }
}
