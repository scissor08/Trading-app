package com.tradingapplication.TradingApplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BuyResponseDTO {
    private String status;
    private String message;
    private double remainingBalance;
    private double transactionAmount;
}
