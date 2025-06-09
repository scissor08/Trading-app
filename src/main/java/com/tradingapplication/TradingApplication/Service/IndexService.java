package com.tradingapplication.TradingApplication.Service;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tradingapplication.TradingApplication.dto.IndexDTO;

@Service
public class IndexService {

    private static final String API_KEY = "e2a99d855cmsh4c2dbbbb514d333p12b8f3jsn5f0a9aeae998";
    private static final String HOST = "apidojo-yahoo-finance-v1.p.rapidapi.com";
    private static final String BASE_URL = "https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-quotes?region=IN&symbols=";
    private static final String[] INDICES = {"^NSEI", "^BSESN", "^IXIC", "^GSPC", "^DJI"};

    public List<IndexDTO> getLiveIndices() {
        List<IndexDTO> result = new ArrayList<>();
        try {
            String symbols = String.join(",", INDICES);
            // URL encode the symbols to escape special characters like '^'
            String encodedSymbols = URLEncoder.encode(symbols, StandardCharsets.UTF_8);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(BASE_URL + encodedSymbols))
                    .header("x-rapidapi-key", API_KEY)
                    .header("x-rapidapi-host", HOST)
                    .GET()
                    .build();

            HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());

            ObjectMapper mapper = new ObjectMapper();
            JsonNode quotes = mapper.readTree(response.body()).path("quoteResponse").path("result");

            for (JsonNode node : quotes) {
                IndexDTO dto = new IndexDTO();
                dto.setSymbol(node.path("symbol").asText());
                dto.setLabel(node.path("shortName").asText());
                dto.setPrice(node.path("regularMarketPrice").asDouble());
                dto.setChange(node.path("regularMarketChange").asDouble());
                dto.setChangePercent(node.path("regularMarketChangePercent").asDouble());
                result.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
