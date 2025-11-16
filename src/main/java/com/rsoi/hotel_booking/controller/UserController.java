package com.rsoi.hotel_booking.controller;

import com.rsoi.hotel_booking.service.UserService;
import com.rsoi.hotel_booking.service.dto.LoginRequest;
import com.rsoi.hotel_booking.service.dto.RegisterRequest;
import com.rsoi.hotel_booking.service.dto.UserDto;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
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

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("registerRequest") RegisterRequest request, Model model) {
        boolean success = userService.register(request);
        if (!success) {
            model.addAttribute("error", "User with email: " + request.getEmail() + " already exists");
            return "user/register";
        }
        return "redirect:/users/login";
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("loginRequest", new LoginRequest());
        return "user/login";
    }

    @PostMapping("/login")
    public String loginUser(@ModelAttribute("loginRequest") LoginRequest loginRequest,
                            HttpSession session,
                            Model model) {
        UserDto user = userService.login(loginRequest.getEmail(), loginRequest.getPassword());

        if (user == null) {
            model.addAttribute("error", "Invalid email or password");
            return "user/login";
        }

        session.setAttribute("currentUser", user);

        String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
        if (redirectUrl != null) {
            session.removeAttribute("redirectAfterLogin");
            return "redirect:" + redirectUrl;
        }
        return "redirect:/rooms";
    }

    @GetMapping("/profile")
    public String userProfile(HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("currentUser");
        model.addAttribute("user", user);
        return "user/profile";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/users/login";
    }
}
