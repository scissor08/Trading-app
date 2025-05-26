package com.tradingapplication.TradingApplication.Service;

import com.tradingapplication.TradingApplication.dto.BuyRequestDTO; 
import com.tradingapplication.TradingApplication.dto.BuyResponseDTO;

import jakarta.servlet.http.HttpSession;

public interface BuyServiceInterface {
	
	 public BuyResponseDTO buyStock(HttpSession session, BuyRequestDTO request);

}
