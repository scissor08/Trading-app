package com.tradingapplication.TradingApplication.Controller;


import com.tradingapplication.TradingApplication.Service.UserRegistrationService;
import com.tradingapplication.TradingApplication.dto.RegistrationRequestUserDTO;
import com.tradingapplication.TradingApplication.dto.RegistrationResponseUserDTO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserRegistrationController {

    @Autowired
    UserRegistrationService registrationService;

    @GetMapping("/user")
    public String getRegistrationPage(){
        return "Registration";
    }

    @PostMapping("/Registration")
    @ResponseBody
    public ResponseEntity<?> addUser(RegistrationRequestUserDTO user){
        return registrationService.addUser(user);
    }
}
