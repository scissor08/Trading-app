package com.tradingapplication.TradingApplication.Service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.Watchlist;
import com.tradingapplication.TradingApplication.Repository.WatchlistRepository;
import com.tradingapplication.TradingApplication.dto.WatchlistRequestDTO;
import com.tradingapplication.TradingApplication.dto.WatchlistResponseDTO;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class WatchlistService implements WatchlistServiceInterface {

    @Autowired
    private WatchlistRepository repository;

    @Override
    public ResponseEntity<?> addToWatchlist(WatchlistRequestDTO dto) {
        // Check if stock already exists by symbol
        Optional<Watchlist> existingItem = repository.findBySymbol(dto.getSymbol());
        if (existingItem.isPresent()) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                                 .body("Stock already exists in watchlist");
        }

        Watchlist newItem = new Watchlist();
        newItem.setSymbol(dto.getSymbol());
        repository.save(newItem); // Save the new item
        return ResponseEntity.ok("Added Successfully");
    }

  

    @Override
    public List<WatchlistResponseDTO> getAllWatchlistItems() {
        return repository.findAll().stream().map(this::mapToDTO).collect(Collectors.toList());
    }

    public Optional<Watchlist> getBySymbol(String symbol) {
        return repository.findBySymbol(symbol);
    }

    private WatchlistResponseDTO mapToDTO(Watchlist item) {
        WatchlistResponseDTO dto = new WatchlistResponseDTO();
        dto.setId(item.getId());
        dto.setSymbol(item.getSymbol());
        return dto;
    }

    public ResponseEntity<?> call(String symbol){ // This method seems redundant if addToWatchlist is used.
        Watchlist item = new Watchlist();
        item.setSymbol(symbol);
        repository.save(item);
        return ResponseEntity.ok("Added to watchlist");
    }

    
    public boolean removeFromWatchlist(Long id) {
        if (repository.existsById(id)) {
            repository.deleteById(id);
            return true;
        }
        return false;
    }
}