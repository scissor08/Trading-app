package com.tradingapplication.TradingApplication.dto;


import lombok.Data;

@Data
public class SellResponseDTO {
    private String status;
    private String message;
    private double remainingBalance;
    private double transactionAmount;
    private String stockSymbol;
    private int quantity;
}

