package com.tradingapplication.TradingApplication.Service;

import com.tradingapplication.TradingApplication.dto.SellRequestDTO;
import com.tradingapplication.TradingApplication.dto.SellResponseDTO;

public interface SellServiceInterface {
    SellResponseDTO sellStock(int userId, SellRequestDTO request);
}

