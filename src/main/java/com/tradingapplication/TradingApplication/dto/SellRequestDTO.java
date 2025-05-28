package com.tradingapplication.TradingApplication.dto;


import lombok.Data;

@Data
public class SellRequestDTO {
    private String symbol;
    private Integer quantity;
    private Double price;
}
