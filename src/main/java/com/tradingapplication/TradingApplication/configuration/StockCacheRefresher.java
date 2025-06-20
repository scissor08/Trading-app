package com.tradingapplication.TradingApplication.configuration;

import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.tradingapplication.TradingApplication.Service.StockService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class StockCacheRefresher {

    private final StockService stockService;

    private final List<String> allSymbols = List.of("AAPL","GOOGL","MSFT", "AMZN", "TSLA", "META", "NFLX", "NVDA", "ADBE", "INTC");

    public static final long TEN_MINUTES = 10 * 60 * 1000;

    @Scheduled(fixedRate = TEN_MINUTES)
    public void refreshCache() {
        for (String symbol : allSymbols) {
            try {
                stockService.fetchStock(symbol); // This will refresh cache and DB
            } catch (Exception e) {
                System.err.println("Failed to refresh stock " + symbol + ": " + e.getMessage());
            }
        }
    }
}
