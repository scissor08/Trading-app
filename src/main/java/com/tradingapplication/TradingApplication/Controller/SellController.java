package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tradingapplication.TradingApplication.Service.SellServiceInterface;
import com.tradingapplication.TradingApplication.dto.SellRequestDTO;
import com.tradingapplication.TradingApplication.dto.SellResponseDTO;

public class SellController {
	@Autowired
	private SellServiceInterface sellServiceInterface;
	@GetMapping("/test")
	public String testApi() {
		return "sell";
	}
	
	@PostMapping("/sell")
	public String sellStock(@RequestParam("userId") int userId,
	                        @RequestParam("symbol") String symbol,
	                        @RequestParam("quantity") int quantity,
	                        Model model) {
	    try {
	        SellRequestDTO request = new SellRequestDTO();
	        request.setSymbol(symbol);
	        request.setQuantity(quantity);

	        SellResponseDTO response = sellServiceInterface.sellStock(userId, request);
	        model.addAttribute("response", response);
	        return "sellSuccess"; // you can show success on same sell.jsp also
	    } catch (Exception e) {
	        model.addAttribute("error", e.getMessage());
	        return "sell"; // redirect back to form with error
	    }
	}
	
}
