package com.tradingapplication.TradingApplication.Controller;

import com.tradingapplication.TradingApplication.Service.StockServiceInterface;
import com.tradingapplication.TradingApplication.dto.StockRequestDTO;
import com.tradingapplication.TradingApplication.dto.StockResponseDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
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
    
    @GetMapping("/view")
    public String viewStocks(Model model) {
        List<StockResponseDTO> stocks = stockService.getAllStocks();
        model.addAttribute("stocks", stocks);
        return "stocks"; // maps to /WEB-INF/views/stocks.jsp
    }
    
}
