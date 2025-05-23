package com.tradingapplication.TradingApplication.configuration;

import java.text.SimpleDateFormat; 
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;

@Configuration
public class ForUserConfiguration {
	
	
	@Autowired
	UserDetailsRepository userRepository;

	 @Bean
	    public CommandLineRunner initData(UserDetailsRepository userDetails) {
	        return args -> {
	        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	            Date dob = sdf.parse("1997-05-22");
	           UserDetails user = new UserDetails();
	           UserAccountDetails account = new UserAccountDetails();
	           UserLog userlog = new UserLog();
	           user.setName("test");
	           user.setUsername("test");
	           user.setEmail("test@gmail.com");
	           user.setMobile("9898989898");
	           user.setPan("poiuy0987p");
	           account.setBalance(10000);
	           userlog.setUsername("test");
	           userlog.setPassword("Test@123");
	           user.setDateOfBirth(dob);
	           user.setUserLog(userlog);
	           user.setUserAccountDetails(account);
	           
	           userRepository.save(user);
	          
	        };
}
}
