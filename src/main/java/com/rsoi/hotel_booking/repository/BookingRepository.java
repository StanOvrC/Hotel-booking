package com.rsoi.hotel_booking.repository;

import com.rsoi.hotel_booking.entity.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;

public interface BookingRepository extends JpaRepository<Booking, Long> {
    List<Booking> findByUserId(Long userId);

    List<Booking> findByRoomId(Long roomId);

    List<Booking> findByStatus(Booking.Status status);

    @Query("""
                SELECT COUNT(b) > 0
                FROM Booking b
                WHERE b.room.id = :roomId
                  AND b.status IN ('CONFIRMED', 'PENDING')
                  AND b.checkInDate < :checkOut
                  AND b.checkOutDate > :checkIn
            """)
    boolean hasOverlap(Long roomId, LocalDate checkIn, LocalDate checkOut);

    @Query("""
                SELECT COUNT(b) > 0
                FROM Booking b
                WHERE b.room.id = :roomId
                  AND b.id <> :bookingId
                  AND b.status IN ('PENDING','CONFIRMED')
                  AND b.checkInDate < :checkOut
                  AND b.checkOutDate > :checkIn
            """)
    boolean hasOverlapExceptSelf(Long roomId, Long bookingId, LocalDate checkIn, LocalDate checkOut);

}
