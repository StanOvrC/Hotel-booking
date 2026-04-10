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
import org.modelmapper.ModelMapper;
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
    private final ModelMapper modelMapper;

    @Override
    public List<BookingDto> getAll() {
        return bookingRepository.findAll().stream()
                .map(this::toDto)
                .toList();
    }

    @Override
    public BookingDto getById(Long id) {
        return toDto(bookingRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Booking with id " + id + " not found")));
    }

    @Override
    public BookingDto create(BookingDto bookingDto) {
        User user = userRepository.findById(bookingDto.getUserId()).orElseThrow(() -> new EntityNotFoundException("User not found"));
        Room room = roomRepository.findById(bookingDto.getRoomId()).orElseThrow(() -> new EntityNotFoundException("Room with id " + bookingDto.getRoomId() + " not found"));

        validateDates(room.getId(), null, bookingDto);

        Booking booking = new Booking();
        booking.setUser(user);
        booking.setRoom(room);
        booking.setStatus(Booking.Status.PENDING);
        booking.setCheckInDate(bookingDto.getCheckInDate());
        booking.setCheckOutDate(bookingDto.getCheckOutDate());
        booking.setTotalPrice(calculateTotal(room, bookingDto));

        bookingRepository.save(booking);

        return toDto(booking);
    }

    @Override
    public BookingDto update(BookingDto bookingDto) {
        Room room = roomRepository.findById(bookingDto.getRoomId()).orElseThrow(() -> new EntityNotFoundException("Room not found"));
        Booking booking = bookingRepository.findById(bookingDto.getId()).orElseThrow(() -> new EntityNotFoundException("Booking not found"));

        validateDates(room.getId(), booking.getId(), bookingDto);

        booking.setRoom(room);
        booking.setCheckInDate(bookingDto.getCheckInDate());
        booking.setCheckOutDate(bookingDto.getCheckOutDate());
        booking.setTotalPrice(calculateTotal(room, bookingDto));

        bookingRepository.save(booking);

        return toDto(booking);
    }

    @Override
    public void delete(Long id) {
        if (!bookingRepository.existsById(id)) {
            throw new EntityNotFoundException("Booking not found");
        }
        bookingRepository.deleteById(id);
    }

    @Override
    public List<BookingDto> getByUser(Long id) {
        return bookingRepository.findByUserId(id).stream()
                .map(this::toDto)
                .toList();
    }

    @Override
    public void cancel(Long bookingId) {
        updateStatus(bookingId, Booking.Status.CANCELLED.name());
    }

    @Override
    @Transactional
    public void updateStatus(Long id, String status) {
        Booking booking = bookingRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("Booking not found"));
        Booking.Status newStatus = Booking.Status.valueOf(status);

        booking.setStatus(newStatus);

        Room room = booking.getRoom();
        switch (newStatus) {
            case CONFIRMED -> room.setStatus(Room.Status.BOOKED);
            case CANCELLED, COMPLETED -> room.setStatus(Room.Status.AVAILABLE);
        }
        roomRepository.save(room);
        bookingRepository.save(booking);
    }

    private void validateDates(Long roomId, Long bookingId, BookingDto bookingDto) {
        if (!bookingDto.getCheckOutDate().isAfter(bookingDto.getCheckInDate())) {
            throw new IllegalStateException("Checkout date must be after check-in date");
        }

        boolean overlap = (bookingId == null)
                ? bookingRepository.hasOverlap(roomId, bookingDto.getCheckInDate(), bookingDto.getCheckOutDate())
                : bookingRepository.hasOverlapExceptSelf(roomId, bookingId, bookingDto.getCheckInDate(), bookingDto.getCheckOutDate());

        if (overlap) {
            throw new IllegalStateException("Room is already booked for these dates");
        }
    }

    private BigDecimal calculateTotal(Room room, BookingDto bookingDto) {
        long days = ChronoUnit.DAYS.between(bookingDto.getCheckInDate(), bookingDto.getCheckOutDate());
        return room.getPricePerNight().multiply(BigDecimal.valueOf(days));
    }

    private BookingDto toDto(Booking booking) {
        return modelMapper.map(booking, BookingDto.class);
    }
}
