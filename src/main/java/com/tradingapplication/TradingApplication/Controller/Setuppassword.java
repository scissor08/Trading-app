package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;
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

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

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
	@PersistenceContext
    private EntityManager entityManager;
	
	
	@GetMapping("/setup-password")
	public String setupPassword(@RequestParam String name, @RequestParam String email, Model model) {
	    model.addAttribute("username", name);
	    model.addAttribute("email", email);
	    return "auth/OauthRegistration";
	}

	    @PostMapping("/setup-password")
	    public String completeRegistration(@RequestParam String password, @RequestParam String email,@RequestParam String name) {
	       UserTable users= new UserTable();
	    	UserLog user = new UserLog();
	    	UserAccountDetails useracc=new UserAccountDetails();
	    	
	    	user.setUsername(name);
	    	String encodedPassword = passwordEncoder.encode(password);
	        user.setPassword(encodedPassword);
	    	user.setRole("USER");
	    	useracc.setBalance(0);
	    	users.setName(name);
	    	users.setUsername(name);
	    	users.setEmail(email);
	        users.setUserLog(user);
	        users.setUserAccountDetails(useracc);
	        userdetails.save(users);
//	        entityManager.flush(); 
//	    	entityManager.clear();  
	        return "redirect:/arise/login";
	    }
}
