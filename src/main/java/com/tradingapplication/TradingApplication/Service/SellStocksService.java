package com.tradingapplication.TradingApplication.Service;

import org.springframework.beans.factory.annotation.Autowired;

import com.tradingapplication.TradingApplication.Entity.StockEntity;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.StockRepository;

public class SellStocksService implements SellingStocksInterface {

	
	
	@Autowired
	private StockRepository stockRepository;
	
	

	@Override
	public String sellStocks(Long id, int quantity) {
		 
	StockEntity stock=	stockRepository.findById(id).orElseThrow(()-> new DataNotFoundException("Stock Not Found..........."));
	
	    if(stock.getQuantity()< quantity) {
	    	
	    	
	    }
	
		
		return null;
	}
	
}
