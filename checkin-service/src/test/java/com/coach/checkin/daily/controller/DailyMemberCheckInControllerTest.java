package com.coach.checkin.daily.controller;

import com.coach.checkin.daily.dto.DailyMemberCheckInCalendarResponse;
import com.coach.checkin.daily.dto.DailyMemberCheckInDayResponse;
import com.coach.checkin.daily.dto.DailyMemberCheckInSummaryResponse;
import com.coach.checkin.daily.service.DailyMemberCheckInService;
import com.coach.checkin.util.CurrentUserUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.server.ResponseStatusException;

import java.time.Instant;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.http.HttpStatus.NOT_FOUND;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

class DailyMemberCheckInControllerTest {

    private DailyMemberCheckInService service;
    private CurrentUserUtil currentUserUtil;
    private MockMvc mockMvc;

    @BeforeEach
    void setUp() {
        service = mock(DailyMemberCheckInService.class);
        currentUserUtil = mock(CurrentUserUtil.class);

        DailyMemberCheckInController controller = new DailyMemberCheckInController(service, currentUserUtil);
        LocalValidatorFactoryBean validator = new LocalValidatorFactoryBean();
        validator.afterPropertiesSet();

        mockMvc = MockMvcBuilders.standaloneSetup(controller)
                .setValidator(validator)
                .setMessageConverters(new MappingJackson2HttpMessageConverter())
                .build();
    }

    @Test
    void upsertShouldReturnSavedDay() throws Exception {
        UUID memberId = UUID.randomUUID();
        when(currentUserUtil.coachEmail()).thenReturn("coach@test.com");
        when(service.upsert(eq("coach@test.com"), any())).thenReturn(
                new DailyMemberCheckInDayResponse(
                        UUID.randomUUID(),
                        LocalDate.of(2026, 4, 10),
                        true,
                        9000,
                        true,
                        "Strong day",
                        Instant.parse("2026-04-10T00:00:00Z"),
                        Instant.parse("2026-04-10T00:05:00Z")
                )
        );

        mockMvc.perform(post("/daily-checkins")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "memberId": "%s",
                                  "checkInDate": "2026-04-10",
                                  "exerciseDone": true,
                                  "stepsCount": 9000,
                                  "notes": "Strong day"
                                }
                                """.formatted(memberId)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.active").value(true))
                .andExpect(jsonPath("$.stepsCount").value(9000));
    }

    @Test
    void upsertShouldReturnBadRequestForNegativeSteps() throws Exception {
        mockMvc.perform(post("/daily-checkins")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "memberId": "%s",
                                  "checkInDate": "2026-04-10",
                                  "stepsCount": -5
                                }
                                """.formatted(UUID.randomUUID())))
                .andExpect(status().isBadRequest());
    }

    @Test
    void getCalendarShouldReturnMonthData() throws Exception {
        UUID memberId = UUID.randomUUID();
        when(currentUserUtil.coachEmail()).thenReturn("coach@test.com");
        when(service.getCalendar("coach@test.com", memberId, YearMonth.of(2026, 4)))
                .thenReturn(new DailyMemberCheckInCalendarResponse(
                        memberId,
                        "2026-04",
                        List.of(new DailyMemberCheckInDayResponse(
                                UUID.randomUUID(),
                                LocalDate.of(2026, 4, 10),
                                true,
                                9000,
                                true,
                                "Strong day",
                                Instant.parse("2026-04-10T00:00:00Z"),
                                Instant.parse("2026-04-10T00:05:00Z")
                        )),
                        new DailyMemberCheckInSummaryResponse(30, 1, 1, 1, 9000)
                ));

        mockMvc.perform(get("/daily-checkins/member/{memberId}/calendar", memberId)
                        .param("month", "2026-04"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.month").value("2026-04"))
                .andExpect(jsonPath("$.summary.activeDays").value(1));
    }

    @Test
    void getSummaryShouldReturnMonthSummary() throws Exception {
        UUID memberId = UUID.randomUUID();
        when(currentUserUtil.coachEmail()).thenReturn("coach@test.com");
        when(service.getSummary("coach@test.com", memberId, YearMonth.of(2026, 4)))
                .thenReturn(new DailyMemberCheckInSummaryResponse(30, 12, 9, 7, 54000));

        mockMvc.perform(get("/daily-checkins/member/{memberId}/summary", memberId)
                        .param("month", "2026-04"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.recordedDays").value(12))
                .andExpect(jsonPath("$.totalSteps").value(54000));
    }

    @Test
    void deleteShouldReturnSuccessMessage() throws Exception {
        UUID checkInId = UUID.randomUUID();
        when(currentUserUtil.coachEmail()).thenReturn("coach@test.com");

        mockMvc.perform(delete("/daily-checkins/{checkInId}", checkInId))
                .andExpect(status().isOk())
                .andExpect(content().string("Daily check-in deleted successfully"));

        verify(service).delete("coach@test.com", checkInId);
    }

    @Test
    void deleteShouldReturnNotFoundWhenRecordMissing() throws Exception {
        UUID checkInId = UUID.randomUUID();
        when(currentUserUtil.coachEmail()).thenReturn("coach@test.com");
        doThrow(new ResponseStatusException(NOT_FOUND, "Daily check-in not found"))
                .when(service).delete("coach@test.com", checkInId);

        mockMvc.perform(delete("/daily-checkins/{checkInId}", checkInId))
                .andExpect(status().isNotFound());
    }
}
