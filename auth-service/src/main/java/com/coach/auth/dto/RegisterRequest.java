package com.coach.auth.dto;

public record RegisterRequest(
        String fullName,
        String email,
        String password
) {}
