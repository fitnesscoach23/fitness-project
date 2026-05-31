package com.coach.checkin.service;

import com.coach.checkin.entity.CheckIn;
import com.coach.checkin.entity.CheckInPhoto;
import com.coach.checkin.repository.CheckInPhotoRepository;
import com.coach.checkin.repository.CheckInRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CheckInPhotoService {

    private final CheckInRepository checkInRepo;
    private final CheckInPhotoRepository photoRepo;
    private final PhotoStorageService storageService;

    public UUID uploadPhoto(String coachEmail, UUID checkInId, String memberName, MultipartFile file) throws Exception {
        CheckIn ci = checkInRepo.findById(checkInId)
                .filter(c -> c.getCoachEmail().equals(coachEmail))
                .orElseThrow(() -> new RuntimeException("Check-in not found"));

        UUID photoId = UUID.randomUUID();

        PhotoStorageService.SavedPhoto storedPhoto = storageService.savePhoto(
                photoId,
                memberName != null && !memberName.isBlank() ? memberName : ci.getMemberId().toString(),
                file
        );

        CheckInPhoto photo = CheckInPhoto.builder()
                .id(photoId)
                .checkInId(checkInId)
                .fileName(storedPhoto.fileName())
                .mimeType(storedPhoto.contentType())
                .size(storedPhoto.size())
                .createdAt(Instant.now())
                .build();

        photoRepo.save(photo);


        return photo.getId();
    }

    public List<CheckInPhoto> listPhotos(String coachEmail, UUID checkInId) {
        CheckIn ci = checkInRepo.findById(checkInId)
                .filter(c -> c.getCoachEmail().equals(coachEmail))
                .orElseThrow(() -> new RuntimeException("Check-in not found"));

        return photoRepo.findByCheckInId(checkInId);
    }
}
