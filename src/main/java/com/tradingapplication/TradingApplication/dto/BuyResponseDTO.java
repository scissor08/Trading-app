package com.tradingapplication.TradingApplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BuyResponseDTO {
	
	    private String status;
	    private String message;
	    private double remainingBalance;
	    private double transactionAmount;
	    private String stockSymbol;
	    private int quantity;

	    // Getters and Setters
	}



