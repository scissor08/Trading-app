package com.tradingapplication.TradingApplication.Service;





import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tradingapplication.TradingApplication.Entity.Stock;
import com.tradingapplication.TradingApplication.Repository.StockRepository;
import com.tradingapplication.TradingApplication.dto.StockRequestDTO;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Service
@RequiredArgsConstructor
public class StockService implements StockServiceInterface {

    private final StockRepository stockRepository;

    @Value("${alpha.api.key}")
    private String apiKey;

    // Static map to associate stock symbols with company domains (used for logo URLs)
    private static final Map<String, String> domainMap = Map.ofEntries(
            Map.entry("AAPL", "apple.com"),
            Map.entry("GOOGL", "abc.xyz"),
            Map.entry("MSFT", "microsoft.com"),
            Map.entry("AMZN", "amazon.com"),
            Map.entry("TSLA", "tesla.com"),
            Map.entry("META", "meta.com"),
            Map.entry("NFLX", "netflix.com"),
            Map.entry("NVDA", "nvidia.com"),
            Map.entry("ADBE", "adobe.com"),
            Map.entry("INTC", "intel.com")
    );

    public StockRequestDTO fetchStock(String symbol) throws Exception {
        String url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=" + symbol + "&apikey=" + apiKey;
        RestTemplate restTemplate = new RestTemplate();

        String json = restTemplate.getForObject(url, String.class);
        System.out.println("API response for " + symbol + ": " + json);  // 🔍 Log the raw response

        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(json);

        // 🛑 Rate limit or unexpected error response
        if (root.has("Note")) {
            throw new Exception("Alpha Vantage rate limit exceeded or throttled: " + root.get("Note").asText());
        }

        JsonNode quoteNode = root.get("Global Quote");

        // 🛑 Empty or malformed response check
        if (quoteNode == null || quoteNode.isEmpty()) {
            throw new Exception("Invalid or empty Global Quote from Alpha Vantage for symbol: " + symbol);
        }

        StockRequestDTO dto = mapper.treeToValue(quoteNode, StockRequestDTO.class);
        dto.setDomain(domainMap.getOrDefault(symbol, ""));

        // Save to DB (update if exists)
        Stock stock = stockRepository.findBySymbol(dto.getSymbol()).orElse(new Stock());

        stock.setSymbol(dto.getSymbol());
        stock.setOpen(dto.getOpen());
        stock.setHigh(dto.getHigh());
        stock.setLow(dto.getLow());
        stock.setPrice(dto.getPrice());
        stock.setVolume(dto.getVolume());
        stock.setLatestTradingDay(dto.getLatestTradingDay());
        stock.setPreviousClose(dto.getPreviousClose());
        stock.setChange(dto.getChange());
        stock.setChangePercent(dto.getChangePercent());
        stock.setDomain(dto.getDomain());

        stockRepository.save(stock);

        return dto;
    }

    public List<StockRequestDTO> fetchMultipleStocks(List<String> symbols) {
        List<StockRequestDTO> stockList = new ArrayList<>();

        for (String symbol : symbols) {
            try {
            	StockRequestDTO dto = fetchStock(symbol);
                stockList.add(dto);

                // 🕒 Respect Alpha Vantage free-tier rate limit: 5 requests/minute
                Thread.sleep(12000);
            } catch (Exception e) {
                System.err.println("❌ Failed to fetch " + symbol + ": " + e.getMessage());
            }
        }

        return stockList;
    }
}
