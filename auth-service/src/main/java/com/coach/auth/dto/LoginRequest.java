package com.coach.auth.dto;

public record LoginRequest(
        String email,
        String password
) {}
