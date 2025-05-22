package com.tradingapplication.TradingApplication.Controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Service.UserServiceInterface;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class UserLoginController {

	@Autowired
	UserServiceInterface service;
	
	@GetMapping("/loginpage")
	public String getRegistrationPage() {
	    return "LoginPage";
	}
	
	@PostMapping("/login")
	public String getUserDashboard(@ModelAttribute UserLog userlog,HttpSession session,Model model) {
		 
		session.setAttribute("userlog", userlog);
		
		model.addAttribute("Username", userlog.getUsername());

		return service.userLogin(userlog, model);
	}
	
	
	
}
