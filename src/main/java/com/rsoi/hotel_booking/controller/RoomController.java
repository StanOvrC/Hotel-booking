package com.rsoi.hotel_booking.controller;

import com.rsoi.hotel_booking.service.RoomService;
import com.rsoi.hotel_booking.service.dto.RoomDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/rooms")
@RequiredArgsConstructor
public class RoomController {
    private final RoomService roomService;

    @GetMapping
    public String getRooms(Model model) {
        List<RoomDto> rooms = roomService.getAll();
        model.addAttribute("rooms", rooms);
        return "rooms";
    }

    @GetMapping("/{id}")
    public String getRoomDetails(@PathVariable("id") Long id, Model model) {
        RoomDto room = roomService.getById(id);
        model.addAttribute("room", room);
        return "room-details";
    }
}
