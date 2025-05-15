package com.tradingapplication.TradingApplication.globalException;

public class BadRequest extends RuntimeException{
	
	public BadRequest(String message) {
		super(message);
	}

}
