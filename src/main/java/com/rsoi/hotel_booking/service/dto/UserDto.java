package com.rsoi.hotel_booking.service.dto;

import com.rsoi.hotel_booking.entity.User;
import lombok.Data;

@Data
public class UserDto {
    private Long id;
    private String username;
    private String password;
    private String email;
    private User.Role role;
}
