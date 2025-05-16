package com.tradingapplication.TradingApplication.globalException;

public class UserAlreadyExist extends RuntimeException{
	
	public UserAlreadyExist (String message) {
		super(message);
	}

}
