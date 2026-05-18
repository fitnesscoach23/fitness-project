package com.coach.checkin.progress.service;

import com.coach.checkin.progress.entity.ProgressCheckInPhoto;
import com.coach.checkin.progress.repository.ProgressCheckInPhotoRepository;
import com.coach.checkin.service.PhotoStorageService;
import com.coach.checkin.simple.entity.ProgressCheckIn;
import com.coach.checkin.simple.repository.ProgressCheckInRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ProgressCheckInPhotoService {

    private final ProgressCheckInPhotoRepository repo;
    private final ProgressCheckInRepository checkInRepo;
    private final PhotoStorageService storageService;

    @Transactional
    public UUID upload(
            String coachEmail,
            UUID checkInId,
            String type,
            MultipartFile file
    ) throws Exception {

        ProgressCheckIn checkIn = checkInRepo.findById(checkInId)
                .filter(c -> c.getCoachEmail().equals(coachEmail))
                .orElseThrow(() -> new RuntimeException("Check-in not found"));

        // Save file first (filename generation and HEIC normalization handled by storage)
        UUID tempId = UUID.randomUUID();
        PhotoStorageService.SavedPhoto storedPhoto = storageService.savePhoto(tempId, file);

        ProgressCheckInPhoto photo = ProgressCheckInPhoto.builder()
                .checkInId(checkInId)
                .type(type)
                .fileName(storedPhoto.fileName())
                .mimeType(storedPhoto.contentType())
                .size(storedPhoto.size())
                .createdAt(Instant.now())
                .build();

        ProgressCheckInPhoto saved = repo.save(photo); // persist(), not merge()

        return saved.getId();
    }




    public List<ProgressCheckInPhoto> list(
            String coachEmail,
            UUID checkInId
    ) {
        // ownership check
        checkInRepo.findById(checkInId)
                .filter(c -> c.getCoachEmail().equals(coachEmail))
                .orElseThrow(() -> new RuntimeException("Check-in not found"));

        return repo.findByCheckInId(checkInId);
    }

    private String getExtension(String originalName) {
        if (originalName == null || !originalName.contains(".")) {
            return "";
        }
        return originalName.substring(originalName.lastIndexOf('.'));
    }
}
