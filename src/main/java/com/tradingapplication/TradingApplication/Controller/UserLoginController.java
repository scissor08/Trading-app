package com.tradingapplication.TradingApplication.Controller;

import java.util.Date; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Entity.UserLogin;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserLoginController {

	@Autowired
	UserService service;
	
	@GetMapping("/loginpage")
	public String getRegistrationPage() {
	    return "LoginPage";
	}
	
	@PostMapping("/login")
	public String getUserDashboard(@ModelAttribute UserLog userlog,HttpSession session,Model model) {
		session.setAttribute("userlog", userlog);
		UserTable usertable = new UserTable();
  	double balance=usertable.getAccount().getBalance();
		String username=usertable.getUsername();
		model.addAttribute("balance", balance);
		model.addAttribute("Username", username);
		return service.userLogin(userlog);
	}
	
	@GetMapping("/dashBoard")
	public String userDashboard(HttpSession session,Model model) {
		UserTable user = new UserTable();
		String username=user.getUsername();
		String email = user.getEmail();
		String mobile = user.getMobile();
		int userid = user.getId();
		Date dob = user.getDateOfBirth();
		String pan = user.getPan();
		double balance = user.getAccount().getBalance();
		model.addAttribute("username", username);
		model.addAttribute("email", email);
		model.addAttribute("mobile", mobile);
		model.addAttribute("userid", userid);
		model.addAttribute("dob", dob);
		model.addAttribute("pan", pan);
		model.addAttribute("balance", balance);
		
		return "UserDashboard";
	}
	
}
