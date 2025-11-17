package com.rsoi.hotel_booking.controller;

import com.rsoi.hotel_booking.service.RoomService;
import com.rsoi.hotel_booking.service.dto.RoomDto;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
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
        return "room/rooms";
    }

    @GetMapping("/{id}")
    public String getRoomDetails(@PathVariable("id") Long id, Model model) {
        RoomDto room = roomService.getById(id);
        model.addAttribute("room", room);
        return "room/room-details";
    }

    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
    @GetMapping("/add")
    public String showAddForm() {
        return "room/add-room";
    }

    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
    @PostMapping("/add")
    public String addRoom(@ModelAttribute("room") RoomDto roomDto) {
        roomService.create(roomDto);
        return "redirect:/rooms";
    }

    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
    @GetMapping("/edit/{id}")
    public String editRoomForm(@PathVariable("id") Long id, Model model) {
        RoomDto room = roomService.getById(id);
        model.addAttribute("room", room);
        return "room/edit-room";
    }

    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
    @PostMapping("/edit")
    public String updateRoom(@ModelAttribute("room") RoomDto roomDto) {
        roomService.update(roomDto);
        return "redirect:/rooms";
    }

    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
    @PostMapping("/delete")
    public String deleteRoom(@RequestParam("id") Long id) {
        roomService.delete(id);
        return "redirect:/rooms";
    }

    @GetMapping("/filter")
    public String filterRooms(
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "maxPrice", required = false) BigDecimal maxPrice,
            Model model
    ) {
        List<RoomDto> filtered = roomService.filterRooms(type, maxPrice);
        model.addAttribute("rooms", filtered);
        return "room/rooms";
    }
}
