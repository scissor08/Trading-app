package com.tradingapplication.TradingApplication.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class IndexDTO {
    private String symbol;
    private String label;
    private double price;
    private double change;
    private double changePercent;
}
