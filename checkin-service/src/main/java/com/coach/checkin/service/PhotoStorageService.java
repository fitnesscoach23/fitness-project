package com.coach.checkin.service;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import software.amazon.awssdk.core.ResponseBytes;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.file.*;
import java.util.List;
import java.util.Locale;
import java.util.Objects;
import java.util.UUID;

import static org.springframework.http.HttpStatus.NOT_FOUND;

@Service
public class PhotoStorageService {

    private final String provider;
    private final String photosDir;
    private final String bucket;
    private final String keyPrefix;
    private final S3Client s3Client;

    public PhotoStorageService(
            @Value("${storage.provider:filesystem}") String provider,
            @Value("${storage.photos-dir:./checkin-photos}") String photosDir,
            @Value("${storage.s3.bucket:}") String bucket,
            @Value("${storage.s3.region:ap-south-1}") String region,
            @Value("${storage.s3.key-prefix:checkin-photos/}") String keyPrefix
    ) {
        this.provider = provider.toLowerCase(Locale.ROOT);
        this.photosDir = photosDir;
        this.bucket = bucket;
        this.keyPrefix = normalizePrefix(keyPrefix);
        this.s3Client = isS3()
                ? S3Client.builder().region(Region.of(region)).build()
                : null;
    }

    public SavedPhoto savePhoto(UUID photoId, MultipartFile file) throws IOException {
        PreparedPhoto preparedPhoto = preparePhoto(file.getBytes(), file.getOriginalFilename(), file.getContentType());
        String storedFileName = photoId + "_" + preparedPhoto.fileName();
        if (isS3()) {
            String objectKey = keyPrefix + storedFileName;
            PutObjectRequest request = PutObjectRequest.builder()
                    .bucket(requiredBucket())
                    .key(objectKey)
                    .contentType(preparedPhoto.contentType())
                    .build();
            s3Client.putObject(request, RequestBody.fromBytes(preparedPhoto.bytes()));
            return new SavedPhoto(storedFileName, preparedPhoto.contentType(), (long) preparedPhoto.bytes().length);
        }

        Path dirPath = Paths.get(photosDir);
        if (!Files.exists(dirPath)) {
            Files.createDirectories(dirPath);
        }
        Path filePath = dirPath.resolve(storedFileName);
        Files.write(filePath, preparedPhoto.bytes(), StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);

        return new SavedPhoto(storedFileName, preparedPhoto.contentType(), (long) preparedPhoto.bytes().length);
    }

    public StoredPhoto load(String fileName) throws IOException {
        if (isS3()) {
            ResponseBytes<GetObjectResponse> objectBytes = s3Client.getObjectAsBytes(
                    GetObjectRequest.builder()
                            .bucket(requiredBucket())
                            .key(keyPrefix + fileName)
                            .build()
            );
            String contentType = objectBytes.response().contentType();
            if (isHeic(fileName, contentType)) {
                return new StoredPhoto(
                        new ByteArrayResource(convertHeicToJpeg(objectBytes.asByteArray())),
                        "image/jpeg"
                );
            }
            return new StoredPhoto(
                    new ByteArrayResource(objectBytes.asByteArray()),
                    contentType
            );
        }

        Path path = Paths.get(photosDir).resolve(fileName);
        if (!Files.exists(path) || !Files.isReadable(path)) {
            throw new ResponseStatusException(NOT_FOUND, "Photo file not found: " + fileName);
        }

        String contentType = Files.probeContentType(path);
        byte[] bytes = Files.readAllBytes(path);
        if (isHeic(fileName, contentType)) {
            return new StoredPhoto(new ByteArrayResource(convertHeicToJpeg(bytes)), "image/jpeg");
        }
        return new StoredPhoto(new ByteArrayResource(bytes), contentType);
    }

    public record SavedPhoto(String fileName, String contentType, Long size) {
    }

    public record StoredPhoto(Resource resource, String contentType) {
    }

    private record PreparedPhoto(byte[] bytes, String fileName, String contentType) {
    }

    private boolean isS3() {
        return "s3".equals(provider);
    }

    private String requiredBucket() {
        if (bucket == null || bucket.isBlank()) {
            throw new IllegalStateException("storage.s3.bucket must be configured when storage.provider=s3");
        }
        return bucket;
    }

    private String sanitizeFileName(String originalFileName) {
        String value = Objects.requireNonNullElse(originalFileName, "upload.bin");
        return value.replace("\\", "_").replace("/", "_");
    }

    private PreparedPhoto preparePhoto(byte[] bytes, String originalFileName, String contentType) throws IOException {
        String fileName = sanitizeFileName(originalFileName);
        if (!isHeic(fileName, contentType)) {
            return new PreparedPhoto(bytes, fileName, normalizeContentType(contentType));
        }

        return new PreparedPhoto(
                convertHeicToJpeg(bytes),
                replaceExtension(fileName, ".jpg"),
                "image/jpeg"
        );
    }

    private boolean isHeic(String fileName, String contentType) {
        String normalizedContentType = Objects.toString(contentType, "").toLowerCase(Locale.ROOT);
        String normalizedFileName = Objects.toString(fileName, "").toLowerCase(Locale.ROOT);

        return normalizedContentType.equals("image/heic")
                || normalizedContentType.equals("image/heif")
                || normalizedContentType.equals("image/heic-sequence")
                || normalizedContentType.equals("image/heif-sequence")
                || normalizedFileName.endsWith(".heic")
                || normalizedFileName.endsWith(".heif");
    }

    private String normalizeContentType(String contentType) {
        return (contentType == null || contentType.isBlank()) ? "application/octet-stream" : contentType;
    }

    private String replaceExtension(String fileName, String extension) {
        int extensionStart = fileName.lastIndexOf('.');
        if (extensionStart <= 0) {
            return fileName + extension;
        }
        return fileName.substring(0, extensionStart) + extension;
    }

    private byte[] convertHeicToJpeg(byte[] bytes) throws IOException {
        IOException lastFailure = null;
        for (List<String> command : List.of(
                List.of("magick", "%s", "%s"),
                List.of("convert", "%s", "%s")
        )) {
            try {
                return runImageMagickConversion(command, bytes);
            } catch (IOException e) {
                lastFailure = e;
            }
        }

        throw new IOException(
                "HEIC/HEIF conversion failed. Install ImageMagick with HEIC support (libheif) in the checkin-service runtime.",
                lastFailure
        );
    }

    private byte[] runImageMagickConversion(List<String> commandTemplate, byte[] bytes) throws IOException {
        Path tempDir = Files.createTempDirectory("checkin-heic-");
        Path input = tempDir.resolve("input.heic");
        Path output = tempDir.resolve("output.jpg");

        try {
            Files.write(input, bytes);
            ProcessBuilder processBuilder = new ProcessBuilder(
                    commandTemplate.get(0),
                    String.format(commandTemplate.get(1), input),
                    String.format(commandTemplate.get(2), output)
            );
            processBuilder.redirectErrorStream(true);

            Process process = processBuilder.start();
            ByteArrayOutputStream processOutput = new ByteArrayOutputStream();
            process.getInputStream().transferTo(processOutput);

            try {
                int exitCode = process.waitFor();
                if (exitCode != 0) {
                    throw new IOException(processOutput.toString());
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                throw new IOException("Interrupted while converting HEIC/HEIF photo", e);
            }

            return Files.readAllBytes(output);
        } finally {
            Files.deleteIfExists(input);
            Files.deleteIfExists(output);
            Files.deleteIfExists(tempDir);
        }
    }

    private String normalizePrefix(String prefix) {
        if (prefix == null || prefix.isBlank()) {
            return "";
        }
        return prefix.endsWith("/") ? prefix : prefix + "/";
    }
}
