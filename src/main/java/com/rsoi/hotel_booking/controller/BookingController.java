package com.rsoi.hotel_booking.controller;

import com.rsoi.hotel_booking.service.BookingService;
import com.rsoi.hotel_booking.service.dto.BookingDto;
import com.rsoi.hotel_booking.service.dto.UserDto;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/bookings")
public class BookingController {
    private final BookingService bookingService;

    @GetMapping
    public String getUserBookings(HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("currentUser");
        if (user == null) return "redirect:/users/login";

        List<BookingDto> bookings;
        if ("MANAGER".equals(user.getRole()) || "ADMIN".equals(user.getRole())) {
            bookings = bookingService.getAll();
        } else {
            bookings = bookingService.getByUser(user.getId());
        }

        model.addAttribute("bookings", bookings);
        return "bookings";
    }

    @GetMapping("/add")
    public String showAddForm(HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("currentUser");
        if (user == null) return "redirect:/users/login";

        BookingDto booking = new BookingDto();
        model.addAttribute("booking", booking);
        return "add-booking";
    }

    @PostMapping("/add")
    public String addBooking(@ModelAttribute("booking") BookingDto bookingDto, HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("currentUser");
        if (user == null) return "redirect:/users/login";

        bookingDto.setUserId(user.getId());
        BookingDto created = bookingService.create(bookingDto);
        if (created == null) {
            model.addAttribute("error", "Room is already booked for these dates");
            return "add-booking";
        }
        return "redirect:/bookings";
    }

    @PostMapping("/cancel")
    public String cancelBooking(@RequestParam("id") Long bookingId, HttpSession session) {
        UserDto user = (UserDto) session.getAttribute("currentUser");
        if (user == null) return "redirect:/users/login";

        BookingDto booking = bookingService.getById(bookingId);
        if (booking == null) return "redirect:/bookings";

        if (!booking.getUserId().equals(user.getId()) &&
                !"ADMIN".equals(user.getRole()) &&
                !"MANAGER".equals(user.getRole())) {
            return "redirect:/bookings";
        }

        bookingService.cancel(bookingId);
        return "redirect:/bookings";
    }

    @GetMapping("/{id}")
    public String bookingDetails(@PathVariable("id") Long bookingId, HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("currentUser");
        if (user == null) return "redirect:/users/login";

        BookingDto booking = bookingService.getById(bookingId);
        if (booking == null) return "redirect:/bookings";

        if (!booking.getUserId().equals(user.getId()) &&
                !"ADMIN".equals(user.getRole()) &&
                !"MANAGER".equals(user.getRole())) {
            return "redirect:/bookings";
        }

        model.addAttribute("booking", booking);
        return "booking-details";
    }
}
