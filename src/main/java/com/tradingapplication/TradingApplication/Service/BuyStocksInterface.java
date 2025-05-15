package com.tradingapplication.TradingApplication.Service;

import org.springframework.http.ResponseEntity;


public interface BuyStocksInterface {
	
	public ResponseEntity<?> buyStocks(Long id,int quantity);
	
	
	

}
