package com.rsoi.hotel_booking.repository;

import com.rsoi.hotel_booking.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
}
