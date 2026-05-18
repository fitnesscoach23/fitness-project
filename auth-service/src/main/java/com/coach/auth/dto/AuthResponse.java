package com.coach.auth.dto;

public record AuthResponse(
        String accessToken,
        String refreshToken
) {}
