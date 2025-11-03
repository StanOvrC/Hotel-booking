package com.rsoi.hotel_booking.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Entity
@Table(name = "rooms")
public class Room {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "number")
    private String number;

    @Enumerated(EnumType.STRING)
    @Column(name = "type")
    private RoomType type;

    @Column(name = "price_per_night")
    private BigDecimal pricePerNight;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private Status status;

    @Column(name = "description", length = 500)
    private String description;

    public enum RoomType {
        SINGLE, DOUBLE, FAMILY
    }

    public enum Status {
        AVAILABLE, BOOKED
    }
}
