package com.coach.checkin.service;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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

    private static final Logger log = LoggerFactory.getLogger(PhotoStorageService.class);

    private final Path photosRoot;

    public PhotoStorageService(
            @Value("${storage.photos-dir:D:/Checkin-Photos}") String photosDir
    ) {
        this.photosRoot = Paths.get(photosDir).toAbsolutePath().normalize();
    }

    public SavedPhoto savePhoto(UUID photoId, String memberName, MultipartFile file) throws IOException {
        PreparedPhoto preparedPhoto = preparePhoto(file.getBytes(), file.getOriginalFilename(), file.getContentType());
        String storedFileName = photoId + "_" + preparedPhoto.fileName();

        String memberFolder = sanitizeFolderName(memberName);
        Path dirPath = photosRoot.resolve(memberFolder).normalize();
        ensureInsidePhotosRoot(dirPath);
        Files.createDirectories(dirPath);

        Path filePath = dirPath.resolve(storedFileName);
        Files.write(filePath, preparedPhoto.bytes(), StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);

        return new SavedPhoto(memberFolder + "/" + storedFileName, preparedPhoto.contentType(), (long) preparedPhoto.bytes().length);
    }

    public StoredPhoto load(String fileName) throws IOException {
        Path path = photosRoot.resolve(fileName).normalize();
        ensureInsidePhotosRoot(path);
        if (!Files.exists(path) || !Files.isReadable(path)) {
            throw new ResponseStatusException(NOT_FOUND, "Photo file not found: " + fileName);
        }

        String contentType = Files.probeContentType(path);
        byte[] bytes = Files.readAllBytes(path);
        if (isHeic(fileName, contentType)) {
            try {
                return new StoredPhoto(new ByteArrayResource(convertHeicToJpeg(bytes)), "image/jpeg");
            } catch (IOException e) {
                log.warn("Serving original HEIC/HEIF photo because JPEG conversion failed for {}", fileName, e);
                return new StoredPhoto(new ByteArrayResource(bytes), normalizeContentType(contentType));
            }
        }
        return new StoredPhoto(new ByteArrayResource(bytes), contentType);
    }

    public record SavedPhoto(String fileName, String contentType, Long size) {
    }

    public record StoredPhoto(Resource resource, String contentType) {
    }

    private record PreparedPhoto(byte[] bytes, String fileName, String contentType) {
    }

    private String sanitizeFileName(String originalFileName) {
        String value = Objects.requireNonNullElse(originalFileName, "upload.bin");
        return value.replace("\\", "_")
                .replace("/", "_")
                .replaceAll("[<>:\"|?*\\p{Cntrl}]", "_")
                .trim();
    }

    private String sanitizeFolderName(String folderName) {
        String value = Objects.requireNonNullElse(folderName, "Unknown Member").trim();
        if (value.isBlank()) {
            value = "Unknown Member";
        }

        String sanitized = value.replace("\\", "_")
                .replace("/", "_")
                .replaceAll("[<>:\"|?*\\p{Cntrl}]", "_")
                .replaceAll("\\s+", " ")
                .trim();

        return sanitized.isBlank() ? "Unknown Member" : sanitized;
    }

    private void ensureInsidePhotosRoot(Path path) {
        if (!path.normalize().startsWith(photosRoot)) {
            throw new ResponseStatusException(NOT_FOUND, "Photo file not found");
        }
    }

    private PreparedPhoto preparePhoto(byte[] bytes, String originalFileName, String contentType) throws IOException {
        String fileName = sanitizeFileName(originalFileName);
        if (!isHeic(fileName, contentType)) {
            return new PreparedPhoto(bytes, fileName, normalizeContentType(contentType));
        }

        try {
            return new PreparedPhoto(
                    convertHeicToJpeg(bytes),
                    replaceExtension(fileName, ".jpg"),
                    "image/jpeg"
            );
        } catch (IOException e) {
            log.warn("Storing original HEIC/HEIF photo because JPEG conversion failed for {}", fileName, e);
            return new PreparedPhoto(bytes, fileName, normalizeContentType(contentType));
        }
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
                List.of("heif-convert", "%s", "%s"),
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
                "HEIC/HEIF conversion failed. Install heif-convert/ImageMagick with HEIC decoder support in the checkin-service runtime.",
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

}
