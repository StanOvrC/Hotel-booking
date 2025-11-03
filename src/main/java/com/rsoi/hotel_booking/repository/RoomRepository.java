package com.rsoi.hotel_booking.repository;

import com.rsoi.hotel_booking.entity.Room;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoomRepository extends JpaRepository<Room, Long> {
    Room findByNumber(String number);

    List<Room> findByType(Room.RoomType type);

    List<Room> findByStatus(Room.Status status);
}
