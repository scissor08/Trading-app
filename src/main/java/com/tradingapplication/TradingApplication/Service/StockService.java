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

    @Override
    public StockRequestDTO fetchStock(String symbol) {
        try {
            Optional<Stock> cached = stockRepository.findBySymbol(symbol);
            if (cached.isPresent()) {
                return convertToDTO(cached.get());
            }

            String url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=" + symbol + "&apikey=" + apiKey;
            RestTemplate restTemplate = new RestTemplate();
            String json = restTemplate.getForObject(url, String.class);

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(json);

            if (root.has("Note")) {
                System.err.println("❌ API limit reached. Using cached data for: " + symbol);
                return cached.map(this::convertToDTO)
                        .orElseThrow(() -> new RuntimeException("Stock not available in DB: " + symbol));
            }

            JsonNode quoteNode = root.get("Global Quote");
            if (quoteNode == null || quoteNode.isEmpty()) {
                throw new Exception("Invalid Global Quote");
            }

            StockRequestDTO dto = mapper.treeToValue(quoteNode, StockRequestDTO.class);
            dto.setDomain(domainMap.getOrDefault(symbol, ""));

            Stock stock = cached.orElse(new Stock());
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

        } catch (Exception e) {
            System.err.println("⚠️ Fetch failed for " + symbol + ": " + e.getMessage());
            return stockRepository.findBySymbol(symbol)
                    .map(this::convertToDTO)
                    .orElseThrow(() -> new RuntimeException("No cached data for symbol: " + symbol));
        }
    }

    @Override
    public List<StockRequestDTO> fetchMultipleStocks(List<String> symbols) {
        List<StockRequestDTO> stockList = new ArrayList<>();

        for (String symbol : symbols) {
            try {
                StockRequestDTO dto = fetchStock(symbol);
                stockList.add(dto);

                // Sleep to avoid hitting free-tier rate limit
                Thread.sleep(12000);
            } catch (Exception e) {
                System.err.println("❌ Failed to fetch " + symbol + ": " + e.getMessage());
            }
        }

        return stockList;
    }

    private StockRequestDTO convertToDTO(Stock stock) {
        StockRequestDTO dto = new StockRequestDTO();
        dto.setSymbol(stock.getSymbol());
        dto.setOpen(stock.getOpen());
        dto.setHigh(stock.getHigh());
        dto.setLow(stock.getLow());
        dto.setPrice(stock.getPrice());
        dto.setVolume(stock.getVolume());
        dto.setLatestTradingDay(stock.getLatestTradingDay());
        dto.setPreviousClose(stock.getPreviousClose());
        dto.setChange(stock.getChange());
        dto.setChangePercent(stock.getChangePercent());
        dto.setDomain(stock.getDomain());
        return dto;
    }
}
