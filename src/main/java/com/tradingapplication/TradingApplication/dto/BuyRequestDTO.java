package com.tradingapplication.TradingApplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BuyRequestDTO {
	private String symbol;
	private Integer quantity;
	private Double price;
	

}
