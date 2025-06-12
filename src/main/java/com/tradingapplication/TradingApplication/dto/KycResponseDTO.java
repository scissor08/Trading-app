package com.tradingapplication.TradingApplication.dto;


import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class KycResponseDTO {
    private boolean success;
    private String decision; // "accept" or "reject"
    private double confidence;
    private String message;
    private Map<String, Object> extractedData; // Optional: extracted fields for preview
}
