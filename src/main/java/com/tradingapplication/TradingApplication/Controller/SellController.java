package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Service.SellServiceInterface;
import com.tradingapplication.TradingApplication.dto.SellRequestDTO;
import com.tradingapplication.TradingApplication.dto.SellResponseDTO;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
@Controller
@RequestMapping("/api")
@Slf4j
public class SellController {
	@Autowired 
	private SellServiceInterface sellServiceInterface;
	@GetMapping("/test")
	public String testApi() {
		return "sell";
	}
	
	@PostMapping("/sell")
	public  ResponseEntity<?> sellStock(
	                        @RequestBody SellRequestDTO request,HttpSession session,
	                        Model model) {
	    try {
	     
	        SellResponseDTO response = sellServiceInterface.sellStock(request,session);
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