package com.tradingapplication.TradingApplication.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;

@Configuration
public class ForUserConfiguration {
	
	
	@Autowired
	UserDetailsRepository userRepository;
	
	 private final PasswordEncoder passwordEncoder;
	 public ForUserConfiguration(PasswordEncoder passwordEncoder) {
	        this.passwordEncoder = passwordEncoder;
	    }

	 @Bean
	    public CommandLineRunner initData(UserDetailsRepository userDetails) {
	        return args -> {
	        	  String username = "test";
	        	if (!userRepository.existsByUsername(username)){	
	            UserTable user = new UserTable();
	           UserAccountDetails account = new UserAccountDetails();
	           UserLog userlog = new UserLog();
	           user.setName("test");
	           user.setUsername("test");
	           user.setEmail("test@gmail.com");
	           account.setBalance(10000);
	           userlog.setUsername("test");
	           String encodedPassword = passwordEncoder.encode("Test@123");
	           userlog.setPassword(encodedPassword);
	           userlog.setRole("USER");
	           user.setUserLog(userlog);
	           user.setUserAccountDetails(account);
	           
	           userRepository.save(user);
	        	}else {
	        		System.out.println("user already exsist");
	        	}
	        	
	        };
	     
	        
}
}
