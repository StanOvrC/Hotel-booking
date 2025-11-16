package com.rsoi.hotel_booking.controller;

import com.rsoi.hotel_booking.service.BookingService;
import com.rsoi.hotel_booking.service.dto.BookingDto;
import com.rsoi.hotel_booking.service.dto.UserDto;
import jakarta.persistence.EntityNotFoundException;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Log4j2
@Controller
@RequiredArgsConstructor
@RequestMapping("/bookings")
public class BookingController {
    private final BookingService bookingService;

    @GetMapping
    public String getUserBookings(HttpSession session, Model model) {
        UserDto user = getCurrentUser(session);

        List<BookingDto> bookings = isAdminOrManager(user)
                ? bookingService.getAll()
                : bookingService.getByUser(user.getId());

        model.addAttribute("bookings", bookings);
        return "booking/bookings";
    }

    @GetMapping("/add")
    public String showAddForm(@RequestParam(name = "roomId", required = false) Long roomId, HttpSession session, Model model) {
        BookingDto booking = new BookingDto();
        if (roomId != null) {
            booking.setRoomId(roomId);
        }

        model.addAttribute("booking", booking);
        return "booking/add-booking";
    }

    @PostMapping("/add")
    public String addBooking(@ModelAttribute("booking") BookingDto bookingDto, HttpSession session, Model model) {
        UserDto user = getCurrentUser(session);
        bookingDto.setUserId(user.getId());

        try {
            bookingService.create(bookingDto);
            return "redirect:/bookings";
        } catch (EntityNotFoundException | IllegalStateException e) {
            model.addAttribute("error", e.getMessage());
            return "booking/add-booking";
        }
    }

    @PostMapping("/cancel")
    public String cancelBooking(@RequestParam("id") Long bookingId, HttpSession session) {
        UserDto user = getCurrentUser(session);

        BookingDto booking = getBookingWithAccessCheck(bookingId, session);
        if (booking == null) {
            return "redirect:/bookings";
        }

        bookingService.cancel(bookingId);
        return "redirect:/bookings";
    }

    @GetMapping("/{id}")
    public String bookingDetails(@PathVariable("id") Long bookingId, HttpSession session, Model model) {
        UserDto user = getCurrentUser(session);

        BookingDto booking = getBookingWithAccessCheck(bookingId, session);
        if (booking == null) {
            return "redirect:/bookings";
        }

        model.addAttribute("booking", booking);
        return "booking/booking-details";
    }

    @PostMapping("/approve")
    public String approveBooking(@RequestParam("id") Long bookingId, HttpSession session) {
        UserDto user = getCurrentUser(session);
        if (!isAdminOrManager(user)) return "redirect:/bookings";

        bookingService.updateStatus(bookingId, "CONFIRMED");
        return "redirect:/bookings";
    }

    @PostMapping("/reject")
    public String rejectBooking(@RequestParam("id") Long bookingId, HttpSession session) {
        UserDto user = getCurrentUser(session);
        if (!isAdminOrManager(user)) return "redirect:/bookings";

        bookingService.updateStatus(bookingId, "CANCELLED");
        return "redirect:/bookings";
    }

    private boolean canAccessBooking(UserDto user, BookingDto booking) {
        return isAdminOrManager(user) || booking.getUserId().equals(user.getId());
    }

    private UserDto getCurrentUser(HttpSession session) {
        return (UserDto) session.getAttribute("currentUser");
    }

    private boolean isAdminOrManager(UserDto user) {
        return "ADMIN".equals(user.getRole()) || "MANAGER".equals(user.getRole());
    }

    private BookingDto getBookingWithAccessCheck(Long bookingId, HttpSession session) {
        UserDto user = getCurrentUser(session);

        try {
            BookingDto booking = bookingService.getById(bookingId);
            return canAccessBooking(user, booking) ? booking : null;
        } catch (EntityNotFoundException e) {
            return null;
        }
    }
}
