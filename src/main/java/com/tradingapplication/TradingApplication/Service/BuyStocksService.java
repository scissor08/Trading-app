package com.tradingapplication.TradingApplication.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.StockEntity;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.StockRepository;
@Service
public class BuyStocksService implements BuyStocksInterface  {

	
	@Autowired
	private StockRepository stockRepository;
	
	@Override
	public ResponseEntity<?> buyStocks(Long id, int quantity) {
		
		StockEntity stock=	stockRepository.findById(id).orElseThrow(()-> new DataNotFoundException("Stock Not Found..........."));
		
		if(stock.getQuantity()> quantity) {
			
			throw new DataNotFoundException("Not Enough Stock Found........");
			
		}
		
		stock.setQuantity(stock.getQuantity()-quantity);
		stockRepository.save(stock);
		
		return ResponseEntity.status(HttpStatus.OK).body("Successfully purchased Quantity :"+ quantity);
	}

}
