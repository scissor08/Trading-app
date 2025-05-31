package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.tradingapplication.TradingApplication.Entity.Watchlist;
import com.tradingapplication.TradingApplication.Service.WatchlistServiceInterface;
import com.tradingapplication.TradingApplication.dto.WatchlistRequestDTO;
import com.tradingapplication.TradingApplication.dto.WatchlistResponseDTO;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/api/watchlist")
public class WatchlistController {

    @Autowired
    private WatchlistServiceInterface watchlistService;

    @PostMapping("/add")
    public ResponseEntity<?> add(@RequestBody WatchlistRequestDTO dto) {
        return watchlistService.addToWatchlist(dto);
    }

    @GetMapping("/watch")
    public String watch() {
    	return "watchlist";
    }
    @DeleteMapping("/remove/{id}")
    public void remove(@PathVariable Long id) {
        watchlistService.removeFromWatchlist(id);
    }

    @GetMapping("")
    public List<WatchlistResponseDTO> getAll() {
        return watchlistService.getAllWatchlistItems();
    }

    @PostMapping("/adds")
    public ResponseEntity<?> addToWatchlist(@RequestBody WatchlistRequestDTO requestDTO) {
        String symbol = requestDTO.getSymbol();
        Optional<Watchlist> existingItem = watchlistService.getBySymbol(symbol);

        if (existingItem.isPresent()) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Stock already exists in watchlist.");
        }

      

        return watchlistService.call(symbol);
    }

}

