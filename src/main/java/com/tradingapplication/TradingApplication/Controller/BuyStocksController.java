package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.tradingapplication.TradingApplication.Service.BuyStocksInterface;
import com.tradingapplication.TradingApplication.dto.BuyStockRequestDTO;

@RestController("/api/trade")
public class BuyStocksController {
	@Autowired
	private BuyStocksInterface buyStocksInterface;
	@PostMapping("/{id}/buy")
	public ResponseEntity<?> buyStock(@PathVariable Long id, @RequestBody BuyStockRequestDTO value) {
	    return buyStocksInterface.buyStocks(id, value.getQuantity());
	}


	


}
