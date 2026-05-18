package com.coach.checkin.daily.controller;

import com.coach.checkin.daily.dto.UpsertDailyMemberCheckInRequest;
import com.coach.checkin.daily.service.DailyMemberCheckInService;
import com.coach.checkin.util.CurrentUserUtil;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.time.YearMonth;
import java.time.format.DateTimeParseException;
import java.util.UUID;

import static org.springframework.http.HttpStatus.BAD_REQUEST;

@RestController
@RequestMapping("/daily-checkins")
@RequiredArgsConstructor
public class DailyMemberCheckInController {

    private final DailyMemberCheckInService service;
    private final CurrentUserUtil currentUserUtil;

    @PostMapping
    public ResponseEntity<?> upsert(@Valid @RequestBody UpsertDailyMemberCheckInRequest request) {
        return ResponseEntity.ok(service.upsert(currentUserUtil.coachEmail(), request));
    }

    @DeleteMapping("/{checkInId}")
    public ResponseEntity<String> delete(@PathVariable UUID checkInId) {
        service.delete(currentUserUtil.coachEmail(), checkInId);
        return ResponseEntity.ok("Daily check-in deleted successfully");
    }

    @GetMapping("/member/{memberId}/calendar")
    public ResponseEntity<?> getCalendar(
            @PathVariable UUID memberId,
            @RequestParam("month") String month
    ) {
        return ResponseEntity.ok(service.getCalendar(currentUserUtil.coachEmail(), memberId, parseMonth(month)));
    }

    @GetMapping("/member/{memberId}/summary")
    public ResponseEntity<?> getSummary(
            @PathVariable UUID memberId,
            @RequestParam("month") String month
    ) {
        return ResponseEntity.ok(service.getSummary(currentUserUtil.coachEmail(), memberId, parseMonth(month)));
    }

    private YearMonth parseMonth(String month) {
        try {
            return YearMonth.parse(month);
        } catch (DateTimeParseException ex) {
            throw new ResponseStatusException(BAD_REQUEST, "month must be in yyyy-MM format");
        }
    }
}
