package com.coach.checkin.simple.controller;

import com.coach.checkin.simple.dto.ProgressCheckInResponse;
import com.coach.checkin.simple.service.ProgressCheckInService;
import com.coach.checkin.util.CurrentUserUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.server.ResponseStatusException;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.http.HttpStatus.NOT_FOUND;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

class ProgressCheckInControllerTest {

    private ProgressCheckInService service;
    private CurrentUserUtil currentUserUtil;
    private MockMvc mockMvc;

    @BeforeEach
    void setUp() {
        service = mock(ProgressCheckInService.class);
        currentUserUtil = mock(CurrentUserUtil.class);

        ProgressCheckInController controller = new ProgressCheckInController(service, currentUserUtil);
        LocalValidatorFactoryBean validator = new LocalValidatorFactoryBean();
        validator.afterPropertiesSet();

        mockMvc = MockMvcBuilders.standaloneSetup(controller)
                .setValidator(validator)
                .setMessageConverters(new MappingJackson2HttpMessageConverter())
                .build();
    }

    @Test
    void deleteShouldReturnSuccessMessage() throws Exception {
        UUID checkInId = UUID.randomUUID();
        when(currentUserUtil.coachEmail()).thenReturn("coach@test.com");

        mockMvc.perform(delete("/progress/checkins/{checkInId}", checkInId)
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().string("Check-in deleted successfully"));

        verify(service).delete("coach@test.com", checkInId);
    }

    @Test
    void deleteShouldReturnNotFoundWhenCheckInMissing() throws Exception {
        UUID checkInId = UUID.randomUUID();
        when(currentUserUtil.coachEmail()).thenReturn("coach@test.com");
        doThrow(new ResponseStatusException(NOT_FOUND, "Check-in not found"))
                .when(service).delete("coach@test.com", checkInId);

        mockMvc.perform(delete("/progress/checkins/{checkInId}", checkInId))
                .andExpect(status().isNotFound());
    }

    @Test
    void deleteShouldReturnBadRequestForInvalidUuid() throws Exception {
        mockMvc.perform(delete("/progress/checkins/not-a-uuid"))
                .andExpect(status().isBadRequest());
    }

    @Test
    void updateShouldReturnOk() throws Exception {
        UUID checkInId = UUID.randomUUID();
        when(currentUserUtil.coachEmail()).thenReturn("coach@test.com");

        mockMvc.perform(put("/progress/checkins/{checkInId}", checkInId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "memberId": "%s",
                                  "weight": 60,
                                  "dietAdherence": 8,
                                  "exerciseRating": 7,
                                  "stepsAvg": 12000,
                                  "notes": "Updated notes",
                                  "submittedAt": "2026-03-20T10:00:00Z"
                                }
                                """.formatted(UUID.randomUUID())))
                .andExpect(status().isOk());

        verify(service).update(
                org.mockito.ArgumentMatchers.eq("coach@test.com"),
                org.mockito.ArgumentMatchers.eq(checkInId),
                org.mockito.ArgumentMatchers.any()
        );
    }

    @Test
    void updateShouldReturnNotFoundWhenCheckInMissing() throws Exception {
        UUID checkInId = UUID.randomUUID();
        when(currentUserUtil.coachEmail()).thenReturn("coach@test.com");
        doThrow(new ResponseStatusException(NOT_FOUND, "Check-in not found"))
                .when(service).update(
                        org.mockito.ArgumentMatchers.eq("coach@test.com"),
                        org.mockito.ArgumentMatchers.eq(checkInId),
                        org.mockito.ArgumentMatchers.any()
                );

        mockMvc.perform(put("/progress/checkins/{checkInId}", checkInId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "memberId": "%s",
                                  "exerciseRating": 7
                                }
                                """.formatted(UUID.randomUUID())))
                .andExpect(status().isNotFound());
    }

    @Test
    void updateShouldReturnBadRequestWhenExerciseRatingIsOutOfRange() throws Exception {
        UUID checkInId = UUID.randomUUID();

        mockMvc.perform(put("/progress/checkins/{checkInId}", checkInId)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "memberId": "%s",
                                  "exerciseRating": 11
                                }
                                """.formatted(UUID.randomUUID())))
                .andExpect(status().isBadRequest());
    }

    @Test
    void listShouldIncludeExerciseRating() throws Exception {
        UUID memberId = UUID.randomUUID();
        when(currentUserUtil.coachEmail()).thenReturn("coach@test.com");
        when(service.getByMember("coach@test.com", memberId)).thenReturn(List.of(
                new ProgressCheckInResponse(
                        UUID.randomUUID(),
                        memberId,
                        new BigDecimal("82.50"),
                        8,
                        7,
                        9,
                        9000,
                        "Strong week",
                        Instant.parse("2026-03-22T10:15:30Z")
                )
        ));

        mockMvc.perform(get("/progress/checkins/member/{memberId}", memberId))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].exerciseRating").value(9));
    }
}
