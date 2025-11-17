package com.rsoi.hotel_booking.controller;

import com.rsoi.hotel_booking.service.UserService;
import com.rsoi.hotel_booking.service.dto.RegisterRequest;
import com.rsoi.hotel_booking.service.dto.UserDto;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/users")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("registerRequest", new RegisterRequest());
        return "user/register";
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        return "user/login";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("registerRequest") RegisterRequest request, Model model) {
        boolean success = userService.register(request);
        if (!success) {
            model.addAttribute("error", "User with email: " + request.getEmail() + " already exists");
            return "user/register";
        }
        return "redirect:/users/login";
    }

    @GetMapping("/profile")
    public String userProfile(@AuthenticationPrincipal UserDetails currentUser, Model model) {
        UserDto user = userService.findByEmail(currentUser.getUsername());
        model.addAttribute("user", user);
        return "user/profile";
    }

//    @GetMapping("/logout")
//    public String logout(HttpSession session) {
//        session.invalidate();
//        return "redirect:/users/login";
//    }
}
