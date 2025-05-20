package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;  
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Service.BuyServiceInterface;
import com.tradingapplication.TradingApplication.dto.BuyRequestDTO;
import com.tradingapplication.TradingApplication.dto.BuyResponseDTO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
@RequestMapping("/api")
public class BuyRequestController {
	@Autowired
	BuyServiceInterface buyServiceInterface;
	
	@PostMapping("/buy")
	public ResponseEntity<?> buyRequest(@RequestParam int id,@RequestBody BuyRequestDTO dto){
		log.info("Received buy request: userId={}, stockSymbol={}, quantity={}",
		         id, dto.getSymbol(), dto.getQuantity());

		try {
		BuyResponseDTO response = buyServiceInterface.buyStock(id, dto);
		
		
		return ResponseEntity.ok(response);
		}catch(DataNotFoundException e) {
			 log.warn("Data not found during buy request for userId {}: {}", id, e.getMessage());
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
			
			
			
		}catch(IllegalArgumentException e) {
			log.warn("Bad request during buy operation for userId {}: {}", id, e.getMessage());
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
			
		}catch(Exception e) {
			log.error("Unexpected error during buy operation for userId {}: {}", id, e.getMessage(), e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		
		
		
		
	
		
	}

	
	
	
}
