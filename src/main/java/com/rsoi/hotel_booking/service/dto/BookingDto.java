package com.rsoi.hotel_booking.service.dto;

import com.rsoi.hotel_booking.entity.Booking;
import com.rsoi.hotel_booking.entity.Room;
import com.rsoi.hotel_booking.entity.User;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class BookingDto {
    private Long id;
    private Long userId;
    private Long roomId;
    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private Booking.Status status;
    private BigDecimal totalPrice;
}
