package com.tradingapplication.TradingApplication.Controller;

import java.util.List; 


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
<<<<<<< HEAD
import org.springframework.ui.Model;
=======
>>>>>>> 868543b170bb52600ff5d557bbfe50ade9850d8d
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Service.PortfolioService;
import com.tradingapplication.TradingApplication.Service.PortfolioServiceInterface;
import com.tradingapplication.TradingApplication.dto.PortfolioResponseDTO;

<<<<<<< HEAD
import jakarta.servlet.http.HttpSession;



=======
>>>>>>> 868543b170bb52600ff5d557bbfe50ade9850d8d
@Controller
@RequestMapping("/api")
public class PortfolioController {
	@Autowired
	private PortfolioServiceInterface portfolioServiceInterface;
	@Autowired
	private  PortfolioService  portfolioService;

	  @GetMapping("holdings")
	    public String showHoldingsById(HttpSession session, Model model) {
		  
		 UserLog name=  (UserLog) session.getAttribute("userlog");
	        List<PortfolioResponseDTO> holdings = portfolioService.getPortfolio(name);
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
