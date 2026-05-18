package com.coach.checkin.simple.controller;

import com.coach.checkin.simple.dto.CreateProgressCheckInRequest;
import com.coach.checkin.simple.service.ProgressCheckInService;
import com.coach.checkin.util.CurrentUserUtil;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/progress/checkins")
@RequiredArgsConstructor
public class ProgressCheckInController {

    private final ProgressCheckInService service;
    private final CurrentUserUtil current;

    @PostMapping
    public ResponseEntity<?> create(@Valid @RequestBody CreateProgressCheckInRequest req) {
        UUID id = service.create(current.coachEmail(), req);
        return ResponseEntity.ok(id);
    }

    @PutMapping("/{checkInId}")
    public ResponseEntity<Void> update(
            @PathVariable UUID checkInId,
            @Valid @RequestBody CreateProgressCheckInRequest req
    ) {
        service.update(current.coachEmail(), checkInId, req);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{checkInId}")
    public ResponseEntity<String> delete(@PathVariable UUID checkInId) {
        service.delete(current.coachEmail(), checkInId);
        return ResponseEntity.ok("Check-in deleted successfully");
    }

    @GetMapping("/member/{memberId}")
    public ResponseEntity<?> list(@PathVariable UUID memberId) {
        return ResponseEntity.ok(
            service.getByMember(current.coachEmail(), memberId)
        );
    }
}
