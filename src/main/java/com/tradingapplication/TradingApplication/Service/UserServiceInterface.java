package com.tradingapplication.TradingApplication.Service;


import org.springframework.http.ResponseEntity;

import com.tradingapplication.TradingApplication.dto.RegistrationRequestUserDTO;

public interface UserServiceInterface {
    public ResponseEntity<?> addUser(RegistrationRequestUserDTO user);
}
