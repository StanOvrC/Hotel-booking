package com.rsoi.hotel_booking;

import com.rsoi.hotel_booking.service.dto.UserDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.IOException;

@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(@NonNull HttpServletRequest request, @NonNull HttpServletResponse response, @NonNull Object handler) throws IOException {

        HttpSession session = request.getSession();
        UserDto user = (UserDto) session.getAttribute("currentUser");

        if (user == null && !request.getRequestURI().contains("/users/login")) {
            session.setAttribute("redirectAfterLogin", request.getRequestURI().substring(request.getContextPath().length()));
            response.sendRedirect(request.getContextPath() + "/users/login");
            return false;
        }

        return true;
    }
}

