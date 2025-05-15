package com.tradingapplication.TradingApplication.Controller;

import com.tradingapplication.TradingApplication.Service.StockServiceInterface;
import com.tradingapplication.TradingApplication.dto.StockRequestDTO;
import com.tradingapplication.TradingApplication.dto.StockResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/stocks")
public class StockController {

    @Autowired
    private StockServiceInterface stockService;

    @PostMapping("/add")
    public StockResponseDTO addStock(@RequestBody StockRequestDTO requestDTO) {
        return stockService.saveStock(requestDTO);
    }

    @GetMapping("/get")
    public List<StockResponseDTO> getAllStocks() {
        return stockService.getAllStocks();
    }
}
