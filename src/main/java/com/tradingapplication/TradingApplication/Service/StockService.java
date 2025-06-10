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
import org.springframework.cache.annotation.Cacheable;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
@RequiredArgsConstructor
public class StockService implements StockServiceInterface {

    private final StockRepository stockRepository;

    @Value("${finnhub.api.key}")
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
    @Cacheable(value = "stocks", key = "#symbol", unless = "#result == null")
    public StockRequestDTO fetchStock(String symbol) {
        try {
            System.out.println("🔁 Fetching from API for: " + symbol); // Log to verify cache usage

            String url = "https://finnhub.io/api/v1/quote?symbol=" + symbol + "&token=" + apiKey;
            RestTemplate restTemplate = new RestTemplate();
            String json = restTemplate.getForObject(url, String.class);

            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(json);

            if (root == null || root.get("c").isNull()) {
                throw new Exception("Invalid response from Finnhub");
            }

            StockRequestDTO dto = new StockRequestDTO();
            dto.setSymbol(symbol);
            dto.setPrice(String.valueOf(root.get("c").asDouble()));
            dto.setChange(String.valueOf(root.get("d").asDouble()));
            dto.setChangePercent(String.valueOf(root.get("dp").asDouble()));
            dto.setHigh(String.valueOf(root.get("h").asDouble()));
            dto.setLow(String.valueOf(root.get("l").asDouble()));
            dto.setOpen(String.valueOf(root.get("o").asDouble()));
            dto.setPreviousClose(String.valueOf(root.get("pc").asDouble()));
            dto.setLatestTradingDay(new SimpleDateFormat("yyyy-MM-dd")
                    .format(new Date(root.get("t").asLong() * 1000L)));
            dto.setDomain(domainMap.getOrDefault(symbol, ""));

         // Inside fetchStock method before saving
            Optional<Stock> existingStockOpt = stockRepository.findBySymbol(symbol);
            Stock stock;
            if (existingStockOpt.isPresent()) {
                stock = existingStockOpt.get();
                // update fields
            } else {
                stock = new Stock();
                stock.setSymbol(symbol);
            }
            // update all fields as before
            stock.setPrice(dto.getPrice());
            stock.setChange(dto.getChange());
            stock.setChangePercent(dto.getChangePercent());
            stock.setHigh(dto.getHigh());
            stock.setLow(dto.getLow());
            stock.setOpen(dto.getOpen());
            stock.setPreviousClose(dto.getPreviousClose());
            stock.setLatestTradingDay(dto.getLatestTradingDay());
            stock.setDomain(dto.getDomain());

            stockRepository.save(stock);


            return dto;

        } catch (Exception e) {
            System.err.println("⚠️ Finnhub fetch failed for " + symbol + ": " + e.getMessage());
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
                Thread.sleep(1200); // to respect Finnhub free tier limit
            } catch (Exception e) {
                System.err.println("❌ Failed to fetch " + symbol + ": " + e.getMessage());
            }
        }

        return stockList;
    }
  public  List<StockRequestDTO> findAllStocks(){
	  List<Stock> stockLists=  stockRepository.findAll();
	  List<StockRequestDTO> stockReqList=new ArrayList<>();
	  for(Stock stock:stockLists) {
		  StockRequestDTO sr=new StockRequestDTO();
		  sr.setChangePercent(stock.getChangePercent());
		  sr.setChange(stock.getChange());
		  sr.setDomain(stock.getDomain());
		  sr.setHigh(stock.getHigh());
		  sr.setLow(stock.getLow());
		  sr.setLatestTradingDay(stock.getLatestTradingDay());
		  sr.setOpen(stock.getOpen());
		  sr.setPreviousClose(stock.getPreviousClose());
		  sr.setPrice(stock.getPrice());
		  sr.setSymbol(stock.getSymbol());
		  stockReqList.add(sr);
	  }
    	return stockReqList;
    }
    private StockRequestDTO convertToDTO(Stock stock) {
        StockRequestDTO dto = new StockRequestDTO();
        dto.setSymbol(stock.getSymbol());
        dto.setPrice(stock.getPrice());
        dto.setChange(stock.getChange());
        dto.setChangePercent(stock.getChangePercent());
        dto.setHigh(stock.getHigh());
        dto.setLow(stock.getLow());
        dto.setOpen(stock.getOpen());
        dto.setPreviousClose(stock.getPreviousClose());
       // dto.setVolume(stock.getVolume());
        dto.setLatestTradingDay(stock.getLatestTradingDay());
        dto.setDomain(stock.getDomain());
        return dto;
    }
}
