package com.rsoi.hotel_booking.service.impl;

import com.rsoi.hotel_booking.entity.Room;
import com.rsoi.hotel_booking.repository.RoomRepository;
import com.rsoi.hotel_booking.service.RoomService;
import com.rsoi.hotel_booking.service.dto.RoomDto;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RoomServiceImpl implements RoomService {
    private final RoomRepository roomRepository;

    private static RoomDto mapToDto(Room room) {
        RoomDto roomDto = new RoomDto();
        roomDto.setId(room.getId());
        roomDto.setNumber(room.getNumber());
        roomDto.setPricePerNight(room.getPricePerNight());
        roomDto.setStatus(String.valueOf(room.getStatus()));
        roomDto.setType(String.valueOf(room.getType()));
        roomDto.setDescription(room.getDescription());
        return roomDto;
    }

    private static Room mapToEntity(RoomDto roomDto) {
        Room room = new Room();
        room.setId(roomDto.getId());
        room.setPricePerNight(roomDto.getPricePerNight());
        room.setNumber(roomDto.getNumber());
        room.setDescription(roomDto.getDescription());
        room.setStatus(Room.Status.valueOf(roomDto.getStatus()));
        room.setType(Room.RoomType.valueOf(roomDto.getType()));
        return room;
    }

    @Override
    public List<RoomDto> getAll() {
        List<Room> rooms = roomRepository.findAll();
        return rooms.stream().map(RoomServiceImpl::mapToDto).toList();
    }

    @Override
    public RoomDto getById(Long id) {
        Room room = roomRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("Room with id " + id + " not found"));
        return mapToDto(room);
    }

    @Override
    public RoomDto create(RoomDto roomDto) {
        Room room = roomRepository.save(mapToEntity(roomDto));
        return getById(room.getId());
    }

    @Override
    public RoomDto update(RoomDto roomDto) {
        if (!roomRepository.existsById(roomDto.getId())) {
            throw new EntityNotFoundException("Room not found");
        }
        roomRepository.save(mapToEntity(roomDto));
        return getById(roomDto.getId());
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

        return rooms.stream().map(r -> {
            RoomDto dto = new RoomDto();
            dto.setId(r.getId());
            dto.setNumber(r.getNumber());
            dto.setType(r.getType().toString());
            dto.setPricePerNight(r.getPricePerNight());
            dto.setStatus(r.getStatus().toString());
            dto.setDescription(r.getDescription());
            return dto;
        }).toList();
    }

}
