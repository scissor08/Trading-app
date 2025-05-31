package com.tradingapplication.TradingApplication.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;

import com.tradingapplication.TradingApplication.Entity.Watchlist;
import com.tradingapplication.TradingApplication.dto.WatchlistRequestDTO;
import com.tradingapplication.TradingApplication.dto.WatchlistResponseDTO;


public interface WatchlistServiceInterface {
	ResponseEntity<?> addToWatchlist(WatchlistRequestDTO dto);
    void removeFromWatchlist(Long id);
    List<WatchlistResponseDTO> getAllWatchlistItems();
    public Optional<Watchlist> getBySymbol(String symbol);
    public ResponseEntity<?> call(String symbol);
 
}
