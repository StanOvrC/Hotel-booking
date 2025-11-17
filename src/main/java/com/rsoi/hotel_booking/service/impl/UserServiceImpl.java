package com.rsoi.hotel_booking.service.impl;

import com.rsoi.hotel_booking.entity.User;
import com.rsoi.hotel_booking.repository.UserRepository;
import com.rsoi.hotel_booking.service.UserService;
import com.rsoi.hotel_booking.service.dto.RegisterRequest;
import com.rsoi.hotel_booking.service.dto.UserDto;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService, UserDetailsService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final ModelMapper modelMapper;

    @Override
    public List<UserDto> getAll() {
        return userRepository.findAll().stream()
                .map(this::toDto)
                .toList();
    }

    @Override
    public UserDto getById(Long id) {
        return toDto(userRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("User with id " + id + " not found")));
    }

    @Override
    public UserDto create(UserDto userDto) {
        if (userRepository.findByEmail(userDto.getEmail()) != null) {
            throw new RuntimeException("User with email " + userDto.getEmail() + "already exists");
        }
        User user = userRepository.save(toEntity(userDto));
        return getById(user.getId());
    }

    @Override
    public UserDto update(UserDto userDto) {
        User existing = userRepository.findById(userDto.getId())
                .orElseThrow(() -> new EntityNotFoundException("User not found"));
        existing.setUsername(userDto.getUsername());
        existing.setEmail(userDto.getEmail());
        existing.setRole(User.Role.valueOf(userDto.getRole()));

        userRepository.save(existing);
        return getById(userDto.getId());
    }

    @Override
    public void delete(Long id) {
        if (!userRepository.existsById(id)) {
            throw new EntityNotFoundException("User not found");
        }
        userRepository.deleteById(id);
    }

    @Override
    public boolean register(RegisterRequest request) {
        if (userRepository.findByEmail(request.getEmail()) != null) {
            return false;
        }

        User user = new User();
        user.setUsername(request.getUsername());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setEmail(request.getEmail());
        user.setRole(User.Role.USER);

        userRepository.save(user);
        return true;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return org.springframework.security.core.userdetails.User.builder()
                .username(user.getEmail())
                .password(user.getPassword())
                .roles(user.getRole().name())
                .build();
    }

    @Override
    public UserDto findByEmail(String email) {
        return toDto(userRepository.findByEmail(email));
    }

    private UserDto toDto(User user) {
        return modelMapper.map(user, UserDto.class);
    }

    private User toEntity(UserDto dto) {
        return modelMapper.map(dto, User.class);
    }
}
