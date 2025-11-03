package com.rsoi.hotel_booking.service.dto;

import com.rsoi.hotel_booking.entity.Room;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class RoomDto {
    private Long id;
    private String number;
    private Room.RoomType type;
    private BigDecimal pricePerNight;
    private Room.Status status;
    private String description;
}
