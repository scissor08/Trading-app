package com.tradingapplication.TradingApplication.dto;

import java.util.Date; 

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BuySellStockRequestDTO {
	
	
	 private String symbol;
	  private Integer Quantity;
	  private Integer price;
	  private String transcationType;
	  private Date transactionTime;
	  

}
