package com.tradingapplication.TradingApplication.Service;

import com.tradingapplication.TradingApplication.Entity.UserEntity;
import com.tradingapplication.TradingApplication.Repository.UserRepository;
import com.tradingapplication.TradingApplication.dto.RegistrationRequestUserDTO;
import com.tradingapplication.TradingApplication.dto.RegistrationResponseUserDTO;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class UserRegistrationService implements UserServiceInterface {

    @Autowired
    UserRepository repository;
    
    @Override
    public ResponseEntity<?> addUser(RegistrationRequestUserDTO userDto) {
        UserEntity user = new UserEntity();
        user.setUsername(userDto.getUsername());
        user.setEmail(userDto.getEmail());
        user.setMobile(userDto.getMobile());
        user.setPassword(userDto.getPassword());
        repository.save(user);
        log.info("Data Saved Successfully . . . ");
        RegistrationResponseUserDTO userDTO=new RegistrationResponseUserDTO();
        userDTO.setUsername(userDto.getUsername());
        
        return ResponseEntity.status(HttpStatus.CREATED).body(userDTO);
        
    }
}
