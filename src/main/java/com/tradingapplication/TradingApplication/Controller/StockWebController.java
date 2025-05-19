package com.tradingapplication.TradingApplication.Controller;

import com.tradingapplication.TradingApplication.Service.StockServiceInterface;
import com.tradingapplication.TradingApplication.dto.StockRequestDTO;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class StockWebController {

    private final StockServiceInterface stockService;

    @GetMapping("/viewstock")
    public String viewStockForm() {
        return "stock"; // stock.jsp
    }

    @PostMapping("/getStock")
    public String getStock(@RequestParam("symbol") String symbol, Model model) {
        try {
            StockRequestDTO stock = stockService.fetchStock(symbol.toUpperCase());
            model.addAttribute("stock", stock);
            return "result"; // result.jsp
        } catch (Exception e) {
            model.addAttribute("error", "Failed to fetch stock: " + e.getMessage());
            return "stock";
        }
    }

    @GetMapping("/stock/{symbol}")
    public String getStockDetails(@PathVariable String symbol, Model model) {
        try {
            StockRequestDTO stock = stockService.fetchStock(symbol.toUpperCase());
            model.addAttribute("stock", stock);
            return "stockDetails";  // stockDetails.jsp
        } catch (Exception e) {
            model.addAttribute("error", "Stock not found: " + symbol);
            return "error";  // Optional error.jsp
        }
    }

    @GetMapping("/stocks")
    public String getAllStocks(Model model) {
        List<String> symbols = List.of("AAPL", "GOOGL", "MSFT", "AMZN", "TSLA", "META", "NFLX", "NVDA", "ADBE", "INTC");
        List<StockRequestDTO> stocks = stockService.fetchMultipleStocks(symbols);
        model.addAttribute("stocks", stocks);
        return "allStocks"; // allStocks.jsp
    }

    @PostConstruct
    public void preloadStocks() {
        List<String> symbols = List.of("AAPL", "GOOGL", "MSFT", "AMZN", "TSLA", "META", "NFLX", "NVDA", "ADBE", "INTC");
        stockService.fetchMultipleStocks(symbols);
    }
}
