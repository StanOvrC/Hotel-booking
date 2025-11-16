package com.rsoi.hotel_booking.service.impl;

import com.rsoi.hotel_booking.entity.User;
import com.rsoi.hotel_booking.repository.UserRepository;
import com.rsoi.hotel_booking.service.EncryptionService;
import com.rsoi.hotel_booking.service.UserService;
import com.rsoi.hotel_booking.service.dto.RegisterRequest;
import com.rsoi.hotel_booking.service.dto.UserDto;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final EncryptionService encryptionService;
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
        user.setPassword(encryptionService.digest(request.getPassword()));
        user.setEmail(request.getEmail());
        user.setRole(User.Role.USER);

        userRepository.save(user);
        return true;
    }

    @Override
    public UserDto login(String email, String password) {
        User user = userRepository.findByEmail(email);

        if (user == null) {
            return null;
        }

        if (!user.getPassword().equals(encryptionService.digest(password))) {
            return null;
        }

        return toDto(user);
    }

    private UserDto toDto(User user) {
        return modelMapper.map(user, UserDto.class);
    }

    private User toEntity(UserDto dto){
        return modelMapper.map(dto, User.class);
    }
}
