package com.rsoi.hotel_booking.controller;

import com.rsoi.hotel_booking.service.RoomService;
import com.rsoi.hotel_booking.service.dto.RoomDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/add")
    public String showAddForm() {
        return "add-room";
    }

    @PostMapping("/add")
    public String addRoom(RoomDto roomDto) {
        roomService.create(roomDto);
        return "redirect:/rooms";
    }

    @GetMapping("/edit/{id}")
    public String editRoomForm(@PathVariable("id") Long id, Model model) {
        RoomDto room = roomService.getById(id);
        model.addAttribute("room", room);
        return "edit-room";
    }

    @PostMapping("/edit")
    public String updateRoom(@ModelAttribute("room") RoomDto roomDto) {
        roomService.update(roomDto);
        return "redirect:/rooms";
    }

    @PostMapping("/delete")
    public String deleteRoom(@RequestParam("id") Long id) {
        roomService.delete(id);
        return "redirect:/rooms";
    }

}
