package com.rsoi.hotel_booking.service.impl;

import com.rsoi.hotel_booking.entity.Booking;
import com.rsoi.hotel_booking.entity.Room;
import com.rsoi.hotel_booking.entity.User;
import com.rsoi.hotel_booking.repository.BookingRepository;
import com.rsoi.hotel_booking.repository.RoomRepository;
import com.rsoi.hotel_booking.repository.UserRepository;
import com.rsoi.hotel_booking.service.BookingService;
import com.rsoi.hotel_booking.service.dto.BookingDto;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Service
@RequiredArgsConstructor
@Log4j2
public class BookingServiceImpl implements BookingService {
    private final BookingRepository bookingRepository;
    private final UserRepository userRepository;
    private final RoomRepository roomRepository;

    private static BookingDto mapToDto(Booking booking) {
        BookingDto bookingDto = new BookingDto();
        bookingDto.setId(booking.getId());
        bookingDto.setCheckInDate(booking.getCheckInDate());
        bookingDto.setCheckOutDate(booking.getCheckOutDate());
        bookingDto.setUserId(booking.getUser().getId());
        bookingDto.setStatus(booking.getStatus());
        bookingDto.setRoomId(booking.getRoom().getId());
        bookingDto.setTotalPrice(booking.getTotalPrice());
        return bookingDto;
    }

    private static Booking mapToEntity(BookingDto bookingDto) {
        Booking booking = new Booking();
        booking.setId(bookingDto.getId());
        booking.setCheckInDate(bookingDto.getCheckInDate());
        booking.setCheckOutDate(bookingDto.getCheckOutDate());
        booking.setStatus(bookingDto.getStatus());
        booking.setTotalPrice(bookingDto.getTotalPrice());
        return booking;
    }

    @Override
    public List<BookingDto> getAll() {
        log.debug("BookingService getAll()");
        List<Booking> bookings = bookingRepository.findAll();
        return bookings.stream().map(BookingServiceImpl::mapToDto).toList();
    }

    @Override
    public BookingDto getById(Long id) {
        log.debug("BookingService getById()");
        Booking booking = bookingRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("Booking with id " + id + " not found"));
        return mapToDto(booking);
    }

    @Override
    public BookingDto create(BookingDto bookingDto) {
        log.debug("BookingService create()");
        User user = userRepository.findById(bookingDto.getUserId())
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        Room room = roomRepository.findByNumber(bookingDto.getRoomNumber());

        Booking booking = mapToEntity(bookingDto);

        long days = ChronoUnit.DAYS.between(bookingDto.getCheckInDate(), bookingDto.getCheckOutDate());
        BigDecimal totalPrice = room.getPricePerNight().multiply(BigDecimal.valueOf(days));
        booking.setTotalPrice(totalPrice);

        booking.setUser(user);
        booking.setRoom(room);
        booking.setStatus(Booking.Status.PENDING);

        booking = bookingRepository.save(booking);
        return getById(booking.getId());
    }

    @Override
    public BookingDto update(BookingDto bookingDto) {
        log.debug("BookingService update()");
        Booking booking = bookingRepository.findById(bookingDto.getId())
                .orElseThrow(() -> new EntityNotFoundException("Booking not found"));

        booking.setCheckInDate(bookingDto.getCheckInDate());
        booking.setCheckOutDate(bookingDto.getCheckOutDate());
        booking.setStatus(bookingDto.getStatus());
        booking.setTotalPrice(bookingDto.getTotalPrice());

        booking.setUser(userRepository.findById(bookingDto.getUserId())
                .orElseThrow(() -> new EntityNotFoundException("User not found")));
        booking.setRoom(roomRepository.findById(bookingDto.getRoomId())
                .orElseThrow(() -> new EntityNotFoundException("Room not found")));

        return mapToDto(bookingRepository.save(booking));
    }

    @Override
    public void delete(Long id) {
        log.debug("BookingService delete()");
        if (!bookingRepository.existsById(id)) {
            throw new EntityNotFoundException("Booking not found");
        }
        bookingRepository.deleteById(id);
    }

    @Override
    public List<BookingDto> getByUser(Long id) {
        log.debug("BookingService getByUser()");
        List<Booking> bookings = bookingRepository.findByUserId(id);
        return bookings.stream().map(BookingServiceImpl::mapToDto).toList();
    }

    @Override
    public void cancel(Long bookingId) {
        log.debug("BookingService cancel()");
        Booking booking = bookingRepository.findById(bookingId).orElse(null);
        if (booking != null) {
            booking.setStatus(Booking.Status.valueOf("CANCELLED"));
            bookingRepository.save(booking);
        }
    }

}
