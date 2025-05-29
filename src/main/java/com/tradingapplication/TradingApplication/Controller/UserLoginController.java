package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;    
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Service.UserServiceInterface;
import com.tradingapplication.TradingApplication.dto.UpdateRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class UserLoginController {

	@Autowired
	UserServiceInterface service;
	
	@GetMapping("/login")
	public String getRegistrationPage() {
	    return "LoginPage";
	}
		
	@PostMapping("/login")
	public String getDashboard(HttpSession session,UserLog userlog,Model model) {
	
		session.setAttribute("userlog", userlog);
	
		model.addAttribute("Username", userlog.getUsername());
	
		return service.userLogin(userlog, model);
	}
	
	@GetMapping("/forget")
	public String getforgetPage() {
		return "ForgetPassword";
	}
	
	@PostMapping("/uservalidate")
	public String sendOtp(@RequestParam String emailOrUsername, Model model,HttpSession session) {
		session.setAttribute("name", emailOrUsername);
		boolean userExists = service.sendOtpToUser(emailOrUsername, model, session);
	    
	    if (userExists) {
	        model.addAttribute("emailOrUsername", emailOrUsername);
	        model.addAttribute("otpSent", true);
	        return "ForgetPassword"; 
	    } else {
	        model.addAttribute("error", "User not found.");
	        return "ForgetPassword"; 
	    }
	}
	@PostMapping("/otpvalidate")
	public String otpValidat(@RequestParam("otp") String otp,HttpSession session,Model model,RedirectAttributes redirectAttributes) {
	String givenOtp=(String) session.getAttribute("otp");
	String userOtp = otp;
	
	if(userOtp==null || !userOtp.equals(givenOtp)){
		model.addAttribute("error", "otp-mismatch");
		return "ForgetPassword";
	}
	
	if(userOtp!=null && userOtp.equals(givenOtp)) {
		model.addAttribute("otpVerified", true);
	return "ForgetPassword";
	
	}
	return "RegistrationPage";
	}
	
	@PostMapping("/updatePassword")
	public String upadatePassword(@RequestParam String password,HttpSession session,Model model) {
		String emailOrUsername=(String) session.getAttribute("name");
		return service.updatePassword(password,emailOrUsername);
	}
	
	@GetMapping("/update")
	public String getUpdatePage(HttpSession session,Model model) {
		UserLog user=(UserLog)session.getAttribute("userlog");
		if(user!=null) {
			return service.getEditPage(session,model);
		}
		return "LoginPage";
	}
	
	@PostMapping("/update")
	public String update(HttpSession session,@ModelAttribute UpdateRequestDTO requestDto,Model model) {
		UserLog user=(UserLog) session.getAttribute("userlog");
		 if(user!=null) {
			return service.updateData(requestDto,session,model);
		}
		return "LoginPage";
	}
}
