package com.tradingapplication.TradingApplication.Controller;


import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.tradingapplication.TradingApplication.Service.StockService;
import com.tradingapplication.TradingApplication.dto.StockRequestDTO;

import java.util.Arrays;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class StockWebController {

    private final StockService stockService;

    @GetMapping("/viewstock")
    public String index() {
        return "stock";
    }

    @PostMapping("/getStock")
    public String getStock(@RequestParam("symbol") String symbol, Model model) {
        try {
        	StockRequestDTO stock = stockService.fetchStock(symbol);
            model.addAttribute("stock", stock);
            return "result";
        } catch (Exception e) {
            model.addAttribute("error", "Error: " + e.getMessage());
            return "stock";
        }
    }

    @GetMapping("/stocks")
    public String getAllStocks(Model model) {
        List<String> symbols = List.of("AAPL", "GOOGL", "MSFT", "AMZN", "TSLA", "META", "NFLX", "NVDA", "ADBE", "INTC");
        List<StockRequestDTO> stocks = stockService.fetchMultipleStocks(symbols);
        model.addAttribute("stocks", stocks);
        return "allStocks";
    }
}
