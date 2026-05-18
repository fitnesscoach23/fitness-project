package com.coach.billing.controller;

import com.coach.billing.dto.CreateSubscriptionRequest;
import com.coach.billing.service.SubscriptionService;
import com.coach.billing.util.CurrentUserUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/billing/subscription")
@RequiredArgsConstructor
public class SubscriptionController {

    private final SubscriptionService service;
    private final CurrentUserUtil current;

    @PostMapping
    public ResponseEntity<?> create(@RequestBody CreateSubscriptionRequest req) {
        UUID id = service.create(current.coachEmail(), req);
        return ResponseEntity.ok(id);
    }

    @GetMapping("/{memberId}")
    public ResponseEntity<?> list(@PathVariable UUID memberId) {
        return ResponseEntity.ok(service.list(current.coachEmail(), memberId));
    }
}
