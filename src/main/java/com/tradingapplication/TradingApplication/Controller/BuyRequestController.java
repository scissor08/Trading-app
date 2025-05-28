package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Service.BuyServiceInterface;
import com.tradingapplication.TradingApplication.dto.BuyRequestDTO;
import com.tradingapplication.TradingApplication.dto.BuyResponseDTO;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/api")
public class BuyRequestController {
	@Autowired
	BuyServiceInterface buyServiceInterface;
	
	@PostMapping("/buy")
	public ResponseEntity<?> buyRequest(@RequestBody BuyRequestDTO dto,HttpSession session){
		log.info("Received buy request: stockSymbol={}, quantity={},price={}",
		          dto.getSymbol(), dto.getQuantity()+""+dto.getPrice());

		try {
		BuyResponseDTO response = buyServiceInterface.buyStock(session, dto);
		
		
		return ResponseEntity.ok(response);
		}catch(DataNotFoundException e) {
			 log.warn("Data not found during buy request for userId {}: {}",  e.getMessage());
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
			
			
			
		}catch(IllegalArgumentException e) {
			log.warn("Bad request during buy operation for userId {}: {}",  e.getMessage());
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
			
		}catch(Exception e) {
			log.error("Unexpected error during buy operation for userId {}: {}", e.getMessage(), e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
		}
		
	}
	

	
	
	
}
