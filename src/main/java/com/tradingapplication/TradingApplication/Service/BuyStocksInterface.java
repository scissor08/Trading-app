package com.tradingapplication.TradingApplication.Service;

import org.springframework.http.ResponseEntity;

import com.tradingapplication.TradingApplication.dto.BuyStockRequestDTO;


public interface BuyStocksInterface {
	
	public ResponseEntity<?> buyStocks(Long id,BuyStockRequestDTO value);
	
	
	

}
