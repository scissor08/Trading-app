package com.tradingapplication.TradingApplication.Service;

import com.tradingapplication.TradingApplication.dto.BuyRequestDTO; 
import com.tradingapplication.TradingApplication.dto.BuyResponseDTO;

public interface BuyServiceInterface {
	
	 public BuyResponseDTO buyStock(int id, BuyRequestDTO request);

}
