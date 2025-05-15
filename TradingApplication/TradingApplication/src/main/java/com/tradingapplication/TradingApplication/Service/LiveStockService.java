package com.tradingapplication.TradingApplication.Service;

import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class LiveStockService {

    private final String API_KEY = "YOUR_API_KEY"; // Get from Alpha Vantage
    private final String BASE_URL = "https://www.alphavantage.co/query";

    public Map<String, String> getStockQuote(String symbol) {
        String url = BASE_URL + "?function=GLOBAL_QUOTE&symbol=" + symbol + "&apikey=" + API_KEY;

        RestTemplate restTemplate = new RestTemplate();
        Map<String, Object> response = restTemplate.getForObject(url, Map.class);

        // Parse result from "Global Quote" section
        Map<String, String> quote = (Map<String, String>) response.get("Global Quote");
        return quote;
    }
}
