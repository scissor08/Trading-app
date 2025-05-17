package com.tradingapplication.TradingApplication.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class StockRequestDTO {
    private String symbol;
    private String name;
    private double price;
    private Integer quantity;
    
    
	    
    
}

