package com.rsoi.hotel_booking.service;

import com.rsoi.hotel_booking.service.dto.UserDto;

import java.util.List;

public interface UserService {
    List<UserDto> getAll();

    UserDto getById(Long id);

    UserDto create(UserDto userDto);

    UserDto update(UserDto userDto);

    void delete(Long id);
}
