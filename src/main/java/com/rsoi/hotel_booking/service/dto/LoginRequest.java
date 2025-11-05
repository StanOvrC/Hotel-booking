package com.rsoi.hotel_booking.service.dto;

import lombok.Data;

@Data
public class LoginRequest {
    private String email;
    private String password;
}
