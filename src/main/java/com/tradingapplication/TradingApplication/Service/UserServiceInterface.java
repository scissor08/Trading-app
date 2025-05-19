package com.tradingapplication.TradingApplication.Service;

import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.Entity.UserLog; 
import com.tradingapplication.TradingApplication.dto.UserRequestDTO; 


public interface UserServiceInterface {

	public String addNewUser(UserRequestDTO requestDto);
	String userLogin(UserLog userlog, Model model);
}
