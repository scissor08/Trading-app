package com.tradingapplication.TradingApplication.Service;


import com.tradingapplication.TradingApplication.dto.*;

import com.tradingapplication.TradingApplication.Entity.*;
import com.tradingapplication.TradingApplication.Repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class StockService implements StockServiceInterface {

    @Autowired
    private StockRepository stockRepository;

    @Override
    public StockResponseDTO saveStock(StockRequestDTO dto) {
        StockDetails stock = new StockDetails();
        stock.setSymbol(dto.getSymbol());
        stock.setStockName(dto.getName());
        stock.setPrice(dto.getPrice());
        stock.setQuantity(dto.getQuantity());

        StockDetails saved = stockRepository.save(stock);

        StockResponseDTO response = new StockResponseDTO();
        response.setId(saved.getStockId());
        response.setSymbol(saved.getSymbol());
        response.setName(saved.getStockName());
        response.setPrice(saved.getPrice());
        response.setQuantity(saved.getQuantity());

        return response;
    }

    @Override
    public List<StockResponseDTO> getAllStocks() {
        List<StockDetails> stocks = stockRepository.findAll();
        return stocks.stream().map(stock -> {
            StockResponseDTO dto = new StockResponseDTO();
            dto.setId(stock.getStockId());
            dto.setSymbol(stock.getSymbol());
            dto.setName(stock.getStockName());
            dto.setPrice(stock.getPrice());
            dto.setQuantity(stock.getQuantity());

            return dto;
        }).collect(Collectors.toList());
    }
}
