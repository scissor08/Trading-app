package com.tradingapplication.TradingApplication.Service;

import com.tradingapplication.TradingApplication.dto.SellRequestDTO;
import com.tradingapplication.TradingApplication.dto.SellResponseDTO;

import jakarta.servlet.http.HttpSession;

public interface SellServiceInterface {
    SellResponseDTO sellStock(SellRequestDTO request,HttpSession session);
}

