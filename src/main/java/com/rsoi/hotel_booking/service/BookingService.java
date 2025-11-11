package com.rsoi.hotel_booking.service;

import com.rsoi.hotel_booking.service.dto.BookingDto;

import java.util.List;

public interface BookingService {
    List<BookingDto> getAll();

    BookingDto getById(Long id);

    BookingDto create(BookingDto bookingDto);

    BookingDto update(BookingDto bookingDto);

    void delete(Long id);

    List<BookingDto> getByUser(Long id);

    void cancel(Long bookingId);

    void updateStatus(Long id, String status);
}
