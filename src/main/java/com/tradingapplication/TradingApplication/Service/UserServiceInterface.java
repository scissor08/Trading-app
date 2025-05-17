package com.tradingapplication.TradingApplication.Service;

import com.tradingapplication.TradingApplication.Entity.UserLog; 
import com.tradingapplication.TradingApplication.dto.UserRequestDTO; 


public interface UserServiceInterface {

	public String addNewUser(UserRequestDTO requestDto);
	public String userLogin(UserLog userlogin);
}
