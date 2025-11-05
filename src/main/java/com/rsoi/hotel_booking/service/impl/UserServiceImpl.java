package com.rsoi.hotel_booking.service.impl;

import com.rsoi.hotel_booking.entity.User;
import com.rsoi.hotel_booking.repository.UserRepository;
import com.rsoi.hotel_booking.service.UserService;
import com.rsoi.hotel_booking.service.dto.UserDto;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;

    private static UserDto mapToDto(User user) {
        UserDto userDto = new UserDto();
        userDto.setId(user.getId());
        userDto.setPassword(user.getPassword());
        userDto.setUsername(user.getUsername());
        userDto.setEmail(user.getEmail());
        userDto.setRole(String.valueOf(user.getRole()));
        return userDto;
    }

    private static User mapToEntity(UserDto userDto) {
        User user = new User();
        user.setId(userDto.getId());
        user.setUsername(userDto.getUsername());
        user.setPassword(userDto.getPassword());
        user.setEmail(userDto.getEmail());
        user.setRole(User.Role.valueOf(userDto.getRole()));
        return user;
    }

    @Override
    public List<UserDto> getAll() {
        List<User> users = userRepository.findAll();
        return users.stream().map(UserServiceImpl::mapToDto).toList();
    }

    @Override
    public UserDto getById(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("User with id " + id + " not found"));
        return mapToDto(user);
    }

    @Override
    public UserDto create(UserDto userDto) {
        User user = userRepository.save(mapToEntity(userDto));
        return getById(user.getId());
    }

    @Override
    public UserDto update(UserDto userDto) {
        if (!userRepository.existsById(userDto.getId())) {
            throw new EntityNotFoundException("User not found");
        }
        userRepository.save(mapToEntity(userDto));
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
    public boolean register(UserDto userDto) {
        if (userRepository.findByEmail(userDto.getEmail()) != null) {
            return false;
        }

        User user = new User();
        user.setUsername(userDto.getUsername());
        user.setPassword(userDto.getPassword());
        user.setEmail(userDto.getEmail());
        user.setRole(User.Role.valueOf(userDto.getRole()));

        userRepository.save(user);
        return true;
    }

    @Override
    public UserDto login(String email, String password) {
        User user = userRepository.findByEmail(email);

        if (user == null) {
            return null;
        }

        if (!user.getPassword().equals(password)) {
            return null;
        }

        UserDto dto = new UserDto();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setEmail(user.getEmail());
        dto.setRole(String.valueOf(user.getRole()));
        return dto;
    }

}
