package com.tradingapplication.TradingApplication.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.UserLogRepository;

@Service
public class SetupPasswordService {
	
	@Autowired
	UserLogRepository userlogrepo;
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	UserDetailsRepository userdetails;
	
	public boolean setupPassword(String username,String password,String email) {
	
	UserTable users= new UserTable();
 	UserLog user = userlogrepo.findByUsername(username);
 	UserAccountDetails useracc=new UserAccountDetails();
   	
 	user.setUsername(username);
 	String encodedPassword = passwordEncoder.encode(password);
    user.setPassword(encodedPassword);
 	user.setRole("USER");
 	useracc.setBalance(0);
 	users.setName(username);
 	users.setUsername(username);
 	users.setEmail(email);
     users.setUserLog(user);
     users.setUserAccountDetails(useracc);
     
     userdetails.save(users);
	
     return true;
	}
}
