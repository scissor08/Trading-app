package com.tradingapplication.TradingApplication.Service;

import java.util.List;   

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.UserLogin;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Repository.UserLogRepository;
import com.tradingapplication.TradingApplication.Repository.UserRepository;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserResponseDTO;
import com.tradingapplication.TradingApplication.globalException.UserAlreadyExist;

import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class UserService implements UserServiceInterface{
	
	@Autowired
	UserRepository userRepository;
	@Autowired
	UserLogRepository logRepository;
	
	@Override
	public String addNewUser(UserRequestDTO requestDto) {
		
		UserLogin userlog = new UserLogin();
		if(userlog.getUsername().equalsIgnoreCase(requestDto.getUsername())) {
			throw new UserAlreadyExist("Try Anyother Username . . .");
		}
		userlog.setUsername(requestDto.getUsername());
		userlog.setPassword(requestDto.getPassword());
		
		logRepository.save(userlog);
		log.info("Data Save Successfully . . . ");
		
		UserTable user= new UserTable();
		user.setUsername(requestDto.getUsername());
		user.setEmail(requestDto.getEmail());
		user.setMobile(requestDto.getMobile());
		user.setDateOfBirth(requestDto.getDateOfBirth());
		user.setPan(requestDto.getPan());
		user.setWalletBalance(0);
		
		userRepository.save(user);
		
		UserResponseDTO response = new UserResponseDTO();
		
		response.setUsername(requestDto.getUsername());
				
		return response.getUsername();
	}
	

	@Override
	public String userLogin(UserLogin userlogin) {
		String username = userlogin.getUsername();
		String password = userlogin.getPassword();
		List<UserLogin> existingUser = logRepository.findAll();
		
		for (UserLogin userpass : existingUser) {
			if(userpass.getUsername().equals(username)&&
			userpass.getPassword().equals(password)) {
				return "UserDashboard";
			}
		}
		
		return "LoginPage";
	}



	
	
}
