package com.coach.checkin.controller;

import com.coach.checkin.entity.CheckInPhoto;
import com.coach.checkin.service.CheckInPhotoService;
import com.coach.checkin.service.PhotoStorageService;
import com.coach.checkin.util.CurrentUserUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/checkin/photos")
@RequiredArgsConstructor
public class PhotoController {

    private final CheckInPhotoService service;
    private final PhotoStorageService storageService;
    private final CurrentUserUtil current;

    @PostMapping("/{checkInId}")
    public ResponseEntity<?> upload(@PathVariable UUID checkInId, @RequestParam("file") MultipartFile file) throws Exception {
        UUID id = service.uploadPhoto(current.coachEmail(), checkInId, file);
        return ResponseEntity.ok(id);
    }

    @GetMapping("/{checkInId}")
    public ResponseEntity<List<CheckInPhoto>> list(@PathVariable UUID checkInId) {
        return ResponseEntity.ok(service.listPhotos(current.coachEmail(), checkInId));
    }

    @GetMapping("/file/{fileName}")
    public ResponseEntity<?> download(@PathVariable String fileName) throws Exception {
        var storedPhoto = storageService.load(fileName);
        MediaType mediaType = (storedPhoto.contentType() != null && !storedPhoto.contentType().isBlank())
                ? MediaType.parseMediaType(storedPhoto.contentType())
                : MediaType.APPLICATION_OCTET_STREAM;
        return ResponseEntity.ok()
                .contentType(mediaType)
                .body(storedPhoto.resource());
    }
}
