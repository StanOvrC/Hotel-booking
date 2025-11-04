package com.rsoi.hotel_booking.service;

import com.rsoi.hotel_booking.service.dto.RoomDto;

import java.util.List;

public interface RoomService {
    List<RoomDto> getAll();

    RoomDto getById(Long id);

    RoomDto create(RoomDto roomDto);

    RoomDto update(RoomDto roomDto);

    void delete(Long id);
}
