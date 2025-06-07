package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Repository.UserAccountDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.UserLogRepository;
import com.tradingapplication.TradingApplication.Security.JwtUtil;
import com.tradingapplication.TradingApplication.Service.SetupPasswordService;

@Controller
@RequestMapping("/oauth2")
public class Setuppassword {
	
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	UserLogRepository userlog;
	@Autowired
	UserDetailsRepository userdetails;
	@Autowired
	UserAccountDetailsRepository useraccount;
	@Autowired
	JwtUtil jwtProvider;
	@Autowired
	AuthenticationManager authenticationManager;
	@Autowired
	SetupPasswordService setupService;
	
	
	@GetMapping("/setup-password")
	public String setupPassword(@RequestParam String name, @RequestParam String email, Model model) {
	    model.addAttribute("username", name);
	    model.addAttribute("email", email);
	    return "auth/OauthRegistration";
	}

	    @PostMapping("/setup-password")
	    public String completeRegistration(@RequestParam String password, @RequestParam String email,@RequestParam String name) {
	      
	    	setupService.setupPassword(name, password, email);

	        return "redirect:/dashboard";
	    }
}
