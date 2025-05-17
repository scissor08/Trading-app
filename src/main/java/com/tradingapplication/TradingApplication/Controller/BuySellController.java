//package com.tradingapplication.TradingApplication.Controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//
//import com.tradingapplication.TradingApplication.Service.BuySellServiceInterface;
//import com.tradingapplication.TradingApplication.dto.BuyResponseDTO;
//import com.tradingapplication.TradingApplication.dto.BuySellStockRequestDTO;
//
//@RestController
//public class BuySellController {
//	@Autowired
//	BuySellServiceInterface buySellServiceInterface;
//	
//	@PostMapping("/buy")
//	public ResponseEntity<BuyResponseDTO> buyStock(@RequestParam String userEmail,
//	                                               @RequestBody BuySellStockRequestDTO dto) {
//	    try {
//	        BuyResponseDTO response = buySellServiceInterface.buyRequest(userEmail, dto);
//	        return ResponseEntity.ok(response);
//	    } catch (RuntimeException e) {
//	        BuyResponseDTO errorResponse = new BuyResponseDTO();
//	        errorResponse.setStatus("failure");
//	        errorResponse.setMessage(e.getMessage());
//	        return ResponseEntity.badRequest().body(errorResponse);
//	    }
//	}
//
//	
//	
//	
//	
//
//}
