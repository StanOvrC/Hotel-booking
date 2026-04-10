package com.rsoi.hotel_booking.service.impl;

import com.rsoi.hotel_booking.entity.Room;
import com.rsoi.hotel_booking.repository.RoomRepository;
import com.rsoi.hotel_booking.service.RoomService;
import com.rsoi.hotel_booking.service.dto.RoomDto;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RoomServiceImpl implements RoomService {
    private final RoomRepository roomRepository;
    private final ModelMapper modelMapper;

    @Override
    public List<RoomDto> getAll() {
        return roomRepository.findAll().stream()
                .map(this::toDto)
                .toList();
    }

    @Override
    public RoomDto getById(Long id) {
        return toDto(roomRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Room with id " + id + " not found")));
    }

    @Override
    public RoomDto create(RoomDto roomDto) {
        Room room = roomRepository.save(toEntity(roomDto));
        return toDto(room);
    }

    @Override
    public RoomDto update(RoomDto roomDto) {
        Room existingRoom = roomRepository.findById(roomDto.getId())
                .orElseThrow(() -> new EntityNotFoundException("Room not found"));
        Room room = toEntity(roomDto);
        room.setId(existingRoom.getId());
        Room updated = roomRepository.save(room);
        return toDto(updated);
    }

    @Override
    public void delete(Long id) {
        if (!roomRepository.existsById(id)) {
            throw new EntityNotFoundException("Room not found");
        }
        roomRepository.deleteById(id);
    }

    @Override
    public List<RoomDto> filterRooms(String type, BigDecimal maxPrice) {
        List<Room> rooms;

        if (type != null && !type.isEmpty() && maxPrice != null) {
            rooms = roomRepository.findByTypeAndPricePerNightLessThanEqual(Room.RoomType.valueOf(type), maxPrice);
        } else if (type != null && !type.isEmpty()) {
            rooms = roomRepository.findByType(Room.RoomType.valueOf(type));
        } else if (maxPrice != null) {
            rooms = roomRepository.findByPricePerNightLessThanEqual(maxPrice);
        } else {
            rooms = roomRepository.findAll();
        }

        return rooms.stream().map(this::toDto).toList();
    }

    private RoomDto toDto(Room room) {
        return modelMapper.map(room, RoomDto.class);
    }

    private Room toEntity(RoomDto dto) {
        return modelMapper.map(dto, Room.class);
    }
}
