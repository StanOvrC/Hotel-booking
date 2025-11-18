package com.rsoi.hotel_booking.controller;

import com.rsoi.hotel_booking.service.UserService;
import com.rsoi.hotel_booking.service.dto.RegisterRequest;
import com.rsoi.hotel_booking.service.dto.UserDto;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
    @GetMapping
    public String getUsers(Model model) {
        List<UserDto> users = userService.getAll();
        model.addAttribute("users", users);
        return "user/users";
    }

    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
    @GetMapping("/{id}")
    public String userDetails(@PathVariable("id") Long userId, Model model) {
        UserDto user = userService.getById(userId);
        model.addAttribute("user", user);
        return "user/userDetails";
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @PostMapping("/delete/{id}")
    public String deleteUser(@PathVariable("id") Long userId) {
        userService.delete(userId);
        return "redirect:/users";
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @GetMapping("/edit/{id}")
    public String editUserForm(@PathVariable("id") Long userId, Model model) {
        UserDto userDto = userService.getById(userId);
        model.addAttribute("user", userDto);
        return "user/user-edit";
    }

    @PreAuthorize("hasAnyRole('ADMIN')")
    @PostMapping("/edit/{id}")
    public String updateUser(@PathVariable("id") Long userId, @ModelAttribute("user") UserDto userDto) {
        userDto.setId(userId);
        userService.update(userDto);
        return "redirect:/users";
    }
}
