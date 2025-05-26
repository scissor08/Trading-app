package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;   
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tradingapplication.TradingApplication.Service.UserServiceInterface;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;

import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping
public class UserRegistrationController {

	@Autowired
	UserServiceInterface userService;
	
	@GetMapping("/registration")
	public String getRegistrationPage() {
	    return "RegistrationPage";
	}

	@PostMapping("/verification")
	public String otpPage(@ModelAttribute UserRequestDTO requestDto,HttpSession session) {
		session.setAttribute("requestDto",requestDto);
		
		return userService.sendOtp(requestDto, session);
	}
	
	@PostMapping("/register")
	public String addUsers(@RequestParam("otp") String otp,HttpSession session,Model model){
		
		String givenOtp=(String) session.getAttribute("otp");
		System.out.println("givenotp"+givenOtp);
		String userOtp = otp;
		System.out.println("userotp"+userOtp);
		
		if(userOtp!=null && userOtp.equals(givenOtp)) {
			
		UserRequestDTO requestDto= (UserRequestDTO) session.getAttribute("requestDto");
		String message = userService.addNewUser(requestDto);
		model.addAttribute("message",message);
		return "Success";	
		}
		return "RegistrationPage";
	}
	
	
	
}
