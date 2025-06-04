package com.tradingapplication.TradingApplication.Service;





import java.util.List;

import com.tradingapplication.TradingApplication.dto.StockRequestDTO;

public interface StockServiceInterface {
    StockRequestDTO fetchStock(String symbol) throws Exception;
    List<StockRequestDTO> fetchMultipleStocks(List<String> symbols);
    public  List<StockRequestDTO> findAllStocks();
}
