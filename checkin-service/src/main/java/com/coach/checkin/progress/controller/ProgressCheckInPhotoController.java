package com.coach.checkin.progress.controller;

import com.coach.checkin.progress.service.ProgressCheckInPhotoService;
import com.coach.checkin.util.CurrentUserUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@RestController
@RequestMapping("/progress/checkins/photos")
@RequiredArgsConstructor
public class ProgressCheckInPhotoController {

    private final ProgressCheckInPhotoService service;
    private final CurrentUserUtil current;

    @PostMapping("/{checkInId}")
    public ResponseEntity<?> upload(
            @PathVariable UUID checkInId,
            @RequestParam("type") String type,
            @RequestParam("file") MultipartFile file
    ) throws Exception {

        UUID id = service.upload(
                current.coachEmail(),
                checkInId,
                type,
                file
        );

        return ResponseEntity.ok(id);
    }

    @GetMapping("/{checkInId}")
    public ResponseEntity<?> list(@PathVariable UUID checkInId) {
        return ResponseEntity.ok(
                service.list(current.coachEmail(), checkInId)
        );
    }
}
