package com.tradingapplication.TradingApplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PortfolioResponseDTO {
	

	private Integer quantity;
	private String symbol;	
	private Double price;
	private Double trancationAmount;
}
