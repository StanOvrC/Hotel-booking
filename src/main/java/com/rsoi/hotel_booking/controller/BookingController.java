package com.rsoi.hotel_booking.controller;

import com.rsoi.hotel_booking.service.BookingService;
import com.rsoi.hotel_booking.service.UserService;
import com.rsoi.hotel_booking.service.dto.BookingDto;
import com.rsoi.hotel_booking.service.dto.UserDto;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
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
    private final UserService userService;

    @GetMapping
    public String getUserBookings(@AuthenticationPrincipal UserDetails currentUser, Model model) {
        UserDto user = getCurrentUser(currentUser);

        List<BookingDto> bookings = isAdminOrManager(user)
                ? bookingService.getAll()
                : bookingService.getByUser(user.getId());

        model.addAttribute("bookings", bookings);
        return "booking/bookings";
    }

    @GetMapping("/add")
    public String showAddForm(@RequestParam(name = "roomId", required = false) Long roomId, Model model) {
        BookingDto booking = new BookingDto();
        if (roomId != null) {
            booking.setRoomId(roomId);
        }

        model.addAttribute("booking", booking);
        return "booking/add-booking";
    }

    @PostMapping("/add")
    public String addBooking(@ModelAttribute("booking") BookingDto bookingDto, @AuthenticationPrincipal UserDetails currentUser, Model model) {
        UserDto user = getCurrentUser(currentUser);
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
    public String cancelBooking(@RequestParam("id") Long bookingId, @AuthenticationPrincipal UserDetails currentUser) {
        UserDto user = getCurrentUser(currentUser);

        BookingDto booking = getBookingWithAccessCheck(bookingId, user);
        if (booking == null) {
            return "redirect:/bookings";
        }

        bookingService.cancel(bookingId);
        return "redirect:/bookings";
    }

    @GetMapping("/{id}")
    public String bookingDetails(@PathVariable("id") Long bookingId, @AuthenticationPrincipal UserDetails currentUser, Model model) {
        UserDto user = getCurrentUser(currentUser);
        BookingDto booking = getBookingWithAccessCheck(bookingId, user);

        if (booking == null) {
            return "redirect:/bookings";
        }

        model.addAttribute("booking", booking);
        return "booking/booking-details";
    }

    @PreAuthorize("hasAnyRole('ADMIN','MANAGER')")
    @PostMapping("/approve")
    public String approveBooking(@RequestParam("id") Long bookingId) {
        bookingService.updateStatus(bookingId, "CONFIRMED");
        return "redirect:/bookings";
    }

    @PreAuthorize("hasAnyRole('ADMIN','MANAGER')")
    @PostMapping("/reject")
    public String rejectBooking(@RequestParam("id") Long bookingId) {
        bookingService.updateStatus(bookingId, "CANCELLED");
        return "redirect:/bookings";
    }

    private UserDto getCurrentUser(UserDetails currentUser) {
        return userService.findByEmail(currentUser.getUsername());
    }

    private boolean canAccessBooking(UserDto user, BookingDto booking) {
        return isAdminOrManager(user) || booking.getUserId().equals(user.getId());
    }

    private boolean isAdminOrManager(UserDto user) {
        return "ADMIN".equals(user.getRole()) || "MANAGER".equals(user.getRole());
    }

    private BookingDto getBookingWithAccessCheck(Long bookingId, UserDto user) {
        try {
            BookingDto booking = bookingService.getById(bookingId);
            return canAccessBooking(user, booking) ? booking : null;
        } catch (EntityNotFoundException e) {
            return null;
        }
    }
}
