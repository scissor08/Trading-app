package com.tradingapplication.TradingApplication.Service;



import com.tradingapplication.TradingApplication.dto.StockRequestDTO;
import com.tradingapplication.TradingApplication.dto.StockResponseDTO;

import java.util.List;

public interface StockServiceInterface {
    StockResponseDTO saveStock(StockRequestDTO requestDTO);
    List<StockResponseDTO> getAllStocks();
}
