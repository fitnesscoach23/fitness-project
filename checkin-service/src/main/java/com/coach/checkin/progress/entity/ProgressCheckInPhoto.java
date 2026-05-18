package com.coach.checkin.progress.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "progress_checkin_photos")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProgressCheckInPhoto {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(nullable = false)
    private UUID checkInId;

    @Column(nullable = false)
    private String type; // FRONT | SIDE | BACK

    @Column(nullable = false)
    private String fileName;

    @Column(nullable = false)
    private String mimeType;

    @Column(nullable = false)
    private Long size;

    @Column(nullable = false)
    private Instant createdAt;
}
