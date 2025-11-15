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
import org.springframework.transaction.annotation.Transactional;

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
        BookingDto dto = mapToDto(booking);
        dto.setRoomNumber(booking.getRoom().getNumber());
        return dto;
    }

    @Override
    public BookingDto create(BookingDto bookingDto) {
        log.debug("BookingService create()");
        User user = userRepository.findById(bookingDto.getUserId())
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        Room room = roomRepository.findById(bookingDto.getRoomId())
                .orElseThrow(() -> new EntityNotFoundException("Room with id " + bookingDto.getRoomId() + " not found"));

        if (bookingRepository.hasOverlap(room.getId(),
                bookingDto.getCheckInDate(),
                bookingDto.getCheckOutDate())) {
            throw new IllegalStateException("Room is already booked for these dates");
        }

        if (!bookingDto.getCheckOutDate().isAfter(bookingDto.getCheckInDate())) {
            throw new IllegalStateException("Checkout date must be after check-in date");
        }

        Booking booking = new Booking();

        long days = ChronoUnit.DAYS.between(bookingDto.getCheckInDate(), bookingDto.getCheckOutDate());
        BigDecimal totalPrice = room.getPricePerNight().multiply(BigDecimal.valueOf(days));

        booking.setTotalPrice(totalPrice);
        booking.setCheckInDate(bookingDto.getCheckInDate());
        booking.setCheckOutDate(bookingDto.getCheckOutDate());
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

        if (bookingRepository.hasOverlapExceptSelf(
                bookingDto.getRoomId(),
                bookingDto.getId(),
                bookingDto.getCheckInDate(),
                bookingDto.getCheckOutDate())) {
            throw new IllegalStateException("Room is already booked for these dates");
        }

        if (!bookingDto.getCheckOutDate().isAfter(bookingDto.getCheckInDate())) {
            throw new IllegalStateException("Checkout date must be after check-in date");
        }

        booking.setCheckInDate(bookingDto.getCheckInDate());
        booking.setCheckOutDate(bookingDto.getCheckOutDate());
        booking.setStatus(bookingDto.getStatus());
        booking.setRoom(roomRepository.findById(bookingDto.getRoomId())
                .orElseThrow(() -> new EntityNotFoundException("Room not found")));
        long days = ChronoUnit.DAYS.between(bookingDto.getCheckInDate(), bookingDto.getCheckOutDate());
        BigDecimal totalPrice = booking.getRoom().getPricePerNight().multiply(BigDecimal.valueOf(days));
        booking.setTotalPrice(totalPrice);

        booking.setUser(userRepository.findById(bookingDto.getUserId())
                .orElseThrow(() -> new EntityNotFoundException("User not found")));

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
        updateStatus(bookingId, "CANCELLED");
    }

    @Override
    @Transactional
    public void updateStatus(Long id, String status) {
        Booking.Status newStatus = Booking.Status.valueOf(status);

        Booking booking = bookingRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Booking not found"));

        booking.setStatus(newStatus);

        Room room = booking.getRoom();

        switch (newStatus) {
            case CONFIRMED -> {
                room.setStatus(Room.Status.BOOKED);
                roomRepository.save(room);
            }
            case CANCELLED, COMPLETED -> {
                room.setStatus(Room.Status.AVAILABLE);
                roomRepository.save(room);
            }
            default -> {
            }
        }

        bookingRepository.save(booking);
    }

}
