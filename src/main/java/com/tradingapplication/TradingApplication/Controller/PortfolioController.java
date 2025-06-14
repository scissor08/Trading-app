package com.tradingapplication.TradingApplication.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.tradingapplication.TradingApplication.Service.PortfolioServiceInterface;
import com.tradingapplication.TradingApplication.dto.PortfolioResponseDTO;

import jakarta.servlet.http.HttpSession;



@Controller

public class PortfolioController {
	@Autowired
	private PortfolioServiceInterface portfolioServiceInterface;
	

	  @GetMapping("/holdings")
	    public String showHoldingsById(HttpSession session, Model model) {
		  
	        List<PortfolioResponseDTO> holdings = portfolioServiceInterface.getPortfolio(session);
	        model.addAttribute("holdings", holdings);
	        return "Holding"; // JSP page name
	    }
	
	
//	@GetMapping("/Portfolio")
//	public ResponseEntity<List<PortfolioResponseDTO>>getPortfolio(@RequestParam int id){
//		
//		
//		List<PortfolioResponseDTO> response = portfolioServiceInterface.getPortfolio(id);
//		
//		
//		return  ResponseEntity.ok(response);
//		
//	}
	
 

//    @GetMapping("/holdings")
//    public String showHoldingsPage(@RequestParam("userId") int userId, Model model) {
//        List<PortfolioResponseDTO> holdings = portfolioService.getPortfolio(userId);
//        model.addAttribute("holdings", holdings);
//        return "Holding"; // JSP name
//    }



	
	
}
