package com.tradingapplication.TradingApplication.Controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.tradingapplication.TradingApplication.Entity.Portfolio;

@RestController
@RequestMapping("/api")
public class PortfolioController {

	
	@GetMapping("/api/Portfolio")
	public ResponseEntity<List<Portfolio>>getPortfolio(@RequestParam int id){
		
		
		
		
		
		return null ;
		
	}
	
	
}
