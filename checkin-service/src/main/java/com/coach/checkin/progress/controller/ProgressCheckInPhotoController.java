package com.coach.checkin.progress.controller;

import com.coach.checkin.progress.service.ProgressCheckInPhotoService;
import com.coach.checkin.service.PhotoStorageService;
import com.coach.checkin.util.CurrentUserUtil;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriUtils;

import java.nio.charset.StandardCharsets;
import java.util.UUID;

@RestController
@RequestMapping("/progress/checkins/photos")
@RequiredArgsConstructor
public class ProgressCheckInPhotoController {

    private final ProgressCheckInPhotoService service;
    private final PhotoStorageService storageService;
    private final CurrentUserUtil current;

    @PostMapping("/{checkInId}")
    public ResponseEntity<?> upload(
            @PathVariable UUID checkInId,
            @RequestParam("type") String type,
            @RequestParam(value = "memberName", required = false) String memberName,
            @RequestParam("file") MultipartFile file
    ) throws Exception {

        UUID id = service.upload(
                current.coachEmail(),
                checkInId,
                type,
                memberName,
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

    @GetMapping("/file/**")
    public ResponseEntity<?> download(HttpServletRequest request) throws Exception {
        String fileName = extractFileName(request);
        var storedPhoto = storageService.load(fileName);
        MediaType mediaType = (storedPhoto.contentType() != null && !storedPhoto.contentType().isBlank())
                ? MediaType.parseMediaType(storedPhoto.contentType())
                : MediaType.APPLICATION_OCTET_STREAM;
        return ResponseEntity.ok()
                .contentType(mediaType)
                .body(storedPhoto.resource());
    }

    private String extractFileName(HttpServletRequest request) {
        String prefix = "/progress/checkins/photos/file/";
        String path = request.getRequestURI();
        int start = path.indexOf(prefix);
        String fileName = start >= 0 ? path.substring(start + prefix.length()) : "";
        return UriUtils.decode(fileName, StandardCharsets.UTF_8);
    }
}
