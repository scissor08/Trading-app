package com.tradingapplication.TradingApplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BuySellStockRequestDTO {
	
	private Long id;
	 private String symbol;
	  private Integer Quantity;
	  private Integer price;
	  private String transcationType;
	  

}
