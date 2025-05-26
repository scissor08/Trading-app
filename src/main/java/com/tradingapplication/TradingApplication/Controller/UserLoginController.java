package com.tradingapplication.TradingApplication.Controller;


import org.springframework.beans.factory.annotation.Autowired;    
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Service.UserServiceInterface;
import com.tradingapplication.TradingApplication.dto.UpdateRequestDTO;

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
	public String getDashboard(HttpSession session,UserLog userlog,Model model) {
	
		session.setAttribute("userlog", userlog);
	
		model.addAttribute("Username", userlog.getUsername());
	
		return service.userLogin(userlog, model);
	}
	
	
	@GetMapping("/updatepage")
	public String getUpdatePage(HttpSession session,Model model) {
		UserLog user=(UserLog)session.getAttribute("userlog");
		if(user!=null) {
			return service.getEditPage(session,model);
		}
		return "LoginPage";
	}
	
	@PostMapping("/updated")
	public String update(HttpSession session,@ModelAttribute UpdateRequestDTO requestDto,Model model) {
		UserLog user=(UserLog) session.getAttribute("userlog");
		 if(user!=null) {
			return service.updateData(requestDto,session,model);
		}
		return "LoginPage";
	}
	
	
}
