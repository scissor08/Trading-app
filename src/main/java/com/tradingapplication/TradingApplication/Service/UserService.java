package com.tradingapplication.TradingApplication.Service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.User;
import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.UserLogRepository;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserResponseDTO;
import com.tradingapplication.TradingApplication.globalException.UserAlreadyExist;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class UserService implements UserServiceInterface{
	
	@Autowired
	UserDetailsRepository userDetailsRepository;
	@Autowired
	UserLogRepository logRepository;
	
	@Override
	public String addNewUser(UserRequestDTO requestDto) {
		
		User user= new User();
		user.setUsername(requestDto.getUsername());
		
		UserLog userlog = new UserLog();
		if(userlog.getUsername().equalsIgnoreCase(requestDto.getUsername())) {
			throw new UserAlreadyExist("Try Anyother Username . . .");
		}
		userlog.setUsername(requestDto.getUsername());
		userlog.setPassword(requestDto.getPassword());
		
		UserAccountDetails accountDetails = new UserAccountDetails();
		accountDetails.setBalance(0);
		
		
		UserDetails userDetails = new UserDetails();
		userDetails.setEmail(requestDto.getEmail());
		userDetails.setMobile(requestDto.getMobile());
		userDetails.setDateOfBirth(requestDto.getDateOfBirth());
		userDetails.setPan(requestDto.getPan());
		userDetails.setUser(user);
		userDetails.setUserAccountDetails(accountDetails);
		userDetails.setUserLog(userlog);
		
	
		userDetailsRepository.save(userDetails);
		
		UserResponseDTO response = new UserResponseDTO();
		response.setUsername(requestDto.getUsername());		
		return response.getUsername();
	}
	

	@Override
	public String userLogin(UserLog userlogin) {
		String username = userlogin.getUsername();
		String password = userlogin.getPassword();
		
		userDetailsRepository.findByUsernameAndPassword(username,password)
				.orElseThrow(()->new DataNotFoundException("LoginPage"));
		
		return "UserDashboard";
	}



	
	
}
