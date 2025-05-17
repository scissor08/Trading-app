package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tradingapplication.TradingApplication.Service.UserServiceInterface;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;



@Controller
@RequestMapping("/user")
public class UserRegistrationController {

	@Autowired
	UserServiceInterface userService;
	
	@GetMapping("/registrationpage")
	public String getRegistrationPage() {
	    return "RegistrationPage";
	}

	
	@PostMapping("/register")
	public String addUsers(@ModelAttribute UserRequestDTO requestDto,Model model){
		String message = userService.addNewUser(requestDto);
		model.addAttribute("message",message);
		return "Success";		
	}
	
}
