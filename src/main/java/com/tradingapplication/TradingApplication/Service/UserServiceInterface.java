package com.tradingapplication.TradingApplication.Service;

import org.springframework.http.ResponseEntity;

import com.tradingapplication.TradingApplication.Entity.UserLogin;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO; 


public interface UserServiceInterface {

	public String addNewUser(UserRequestDTO requestDto);
	public ResponseEntity<?> getAllStocks();
	public String userLogin(UserLogin userlogin);
}
