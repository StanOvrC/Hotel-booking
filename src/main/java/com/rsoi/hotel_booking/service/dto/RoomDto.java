package com.rsoi.hotel_booking.service.dto;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class RoomDto {
    private Long id;
    private String number;
    private String type;
    private BigDecimal pricePerNight;
    private String status;
    private String description;
}
