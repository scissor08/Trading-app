package com.tradingapplication.TradingApplication.Controller;

import java.util.List; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tradingapplication.TradingApplication.Service.PortfolioServiceInterface;
import com.tradingapplication.TradingApplication.dto.PortfolioResponseDTO;

@Controller
@RequestMapping("/api")
public class PortfolioController {
	@Autowired
	private PortfolioServiceInterface portfolioServiceInterface;

	
	@GetMapping("/Portfolio")
	public ResponseEntity<List<PortfolioResponseDTO>>getPortfolio(@RequestParam int id){
		
		
		List<PortfolioResponseDTO> response = portfolioServiceInterface.getPortfolio(id);
		
		
		return  ResponseEntity.ok(response);
		
	}
	
	
}
