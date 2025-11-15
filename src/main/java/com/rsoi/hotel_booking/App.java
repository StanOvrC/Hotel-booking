package com.rsoi.hotel_booking;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
public class App implements WebMvcConfigurer {

    private final LoginInterceptor loginInterceptor;

    public App(LoginInterceptor loginInterceptor) {
        this.loginInterceptor = loginInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/bookings/**", "/rooms/add", "/rooms/edit/**", "/rooms/delete/**");
    }

    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }

}