package com.tradingapplication.TradingApplication.Service;


import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserResponseDTO;
import com.tradingapplication.TradingApplication.globalException.UserAlreadyExist;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class UserService implements UserServiceInterface{
	
	@Autowired
	UserDetailsRepository userDetailsRepository;

	
	@Override
	public String addNewUser(UserRequestDTO requestDto) {
		
		
		UserLog userlog = new UserLog();
		if(requestDto.getUsername().equalsIgnoreCase(userlog.getUsername())) {
			throw new UserAlreadyExist("Try Anyother Username . . .");
		}
		userlog.setUsername(requestDto.getUsername().toUpperCase());
		userlog.setPassword(requestDto.getPassword());
		
		UserAccountDetails accountDetails = new UserAccountDetails();
		accountDetails.setBalance(0);
		
		
		UserDetails userDetails = new UserDetails();
		userDetails.setUsername(requestDto.getUsername().toUpperCase());
		userDetails.setEmail(requestDto.getEmail());
		userDetails.setMobile(requestDto.getMobile());
		userDetails.setDateOfBirth(requestDto.getDateOfBirth());
		userDetails.setPan(requestDto.getPan().toUpperCase());
		userDetails.setUserAccountDetails(accountDetails);
		userDetails.setUserLog(userlog);
		
	
		userDetailsRepository.save(userDetails);
		
		UserResponseDTO response = new UserResponseDTO();
		response.setUsername(requestDto.getUsername().toUpperCase());		
		return response.getUsername();
	}
	

	@Override
	public String userLogin(UserLog userlog,Model model) {
		String username = userlog.getUsername().toUpperCase();
		String password = userlog.getPassword();
		
		
		UserDetails existingUsers=userDetailsRepository.findByUsername(username).orElseThrow(()->new DataNotFoundException("LoginPage"));
				
		if(username.equals(existingUsers.getUserLog().getUsername()) && password.equals(existingUsers.getUserLog().getPassword())) {
			model.addAttribute("balance",existingUsers.getUserAccountDetails().getBalance());
			model.addAttribute("username", existingUsers.getUsername());
			return "UserDashboard";
		}
		return "LoginPage";
						
			
	}

}
