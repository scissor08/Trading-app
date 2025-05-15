package com.tradingapplication.TradingApplication.Service;

import org.springframework.stereotype.Service;

@Service
public interface SellingStocksInterface {

	
	public String sellStocks(Long id,int quantity);
}
