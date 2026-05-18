package com.coach.checkin.controller;

import com.coach.checkin.dto.CreateCheckInRequest;
import com.coach.checkin.dto.UpdateCheckInRequest;
import com.coach.checkin.service.CheckInService;
import com.coach.checkin.util.CurrentUserUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/checkins")
@RequiredArgsConstructor
public class CheckInController {

    private final CheckInService service;
    private final CurrentUserUtil current;

    @PostMapping
    public ResponseEntity<?> create(@RequestBody CreateCheckInRequest req) {
        UUID id = service.createCheckIn(current.coachEmail(), req);
        return ResponseEntity.ok(id);
    }

    @PutMapping("/{checkInId}")
    public ResponseEntity<?> update(@PathVariable UUID checkInId,
                                    @RequestBody UpdateCheckInRequest req) {
        service.updateCheckIn(current.coachEmail(), checkInId, req);
        return ResponseEntity.ok("Check-in updated successfully");
    }

    @GetMapping("/member/{memberId}")
    public ResponseEntity<?> list(@PathVariable UUID memberId) {
        return ResponseEntity.ok(service.getCheckIns(current.coachEmail(), memberId));
    }
}
