package com.coach.diet_review.controller;

import com.coach.diet_review.dto.DietReviewRequest;
import com.coach.diet_review.dto.DietReviewResponse;
import com.coach.diet_review.service.DietReviewService;
import com.coach.diet_review.util.CurrentUserUtil;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/diet")
@RequiredArgsConstructor
public class DietReviewController {

    private final DietReviewService service;
    private final CurrentUserUtil currentUserUtil;

    @PostMapping("/review")
    public ResponseEntity<DietReviewResponse> review(@Valid @RequestBody DietReviewRequest request) {
        return ResponseEntity.ok(service.review(currentUserUtil.coachEmail(), request));
    }
}
