package com.coach.checkin.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "checkin_photos")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CheckInPhoto {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(name = "check_in_id", nullable = false)
    private UUID checkInId;

    @Column(name = "file_name", nullable = false)
    private String fileName;

    @Column(name = "mime_type", nullable = false)
    private String mimeType;

    @Column(name = "size", nullable = false)
    private Long size;

    @Column(name = "created_at", nullable = false)
    private Instant createdAt;
}
