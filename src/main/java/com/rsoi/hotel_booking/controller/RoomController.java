package com.rsoi.hotel_booking.controller;

import com.rsoi.hotel_booking.service.RoomService;
import com.rsoi.hotel_booking.service.dto.RoomDto;
import com.rsoi.hotel_booking.service.dto.UserDto;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
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
        return "rooms";
    }

    @GetMapping("/{id}")
    public String getRoomDetails(@PathVariable("id") Long id, Model model) {
        RoomDto room = roomService.getById(id);
        model.addAttribute("room", room);
        return "room-details";
    }

    @GetMapping("/add")
    public String showAddForm(HttpSession session) {
        UserDto user = (UserDto) session.getAttribute("currentUser");
        if (user == null || "USER".equals(user.getRole())) {
            return "redirect:/rooms";
        }
        return "add-room";
    }

    @PostMapping("/add")
    public String addRoom(RoomDto roomDto, HttpSession session) {
        UserDto user = (UserDto) session.getAttribute("currentUser");
        if (user == null || "USER".equals(user.getRole())) {
            return "redirect:/rooms";
        }
        roomService.create(roomDto);
        return "redirect:/rooms";
    }

    @GetMapping("/edit/{id}")
    public String editRoomForm(@PathVariable("id") Long id, Model model, HttpSession session) {
        UserDto user = (UserDto) session.getAttribute("currentUser");
        if (user == null || "USER".equals(user.getRole())) {
            return "redirect:/rooms";
        }
        RoomDto room = roomService.getById(id);
        model.addAttribute("room", room);
        return "edit-room";
    }

    @PostMapping("/edit")
    public String updateRoom(@ModelAttribute("room") RoomDto roomDto, HttpSession session) {
        UserDto user = (UserDto) session.getAttribute("currentUser");
        if (user == null || "USER".equals(user.getRole())) {
            return "redirect:/rooms";
        }
        roomService.update(roomDto);
        return "redirect:/rooms";
    }

    @PostMapping("/delete")
    public String deleteRoom(@RequestParam("id") Long id, HttpSession session) {
        UserDto user = (UserDto) session.getAttribute("currentUser");
        if (user == null || "USER".equals(user.getRole())) {
            return "redirect:/rooms";
        }
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
        return "rooms";
    }


}
