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
        Watchlist item = repository.findBySymbol(dto.getSymbol()).orElse(null);
    if(item!=null) {
    	
    	        return ResponseEntity.status(HttpStatus.CONFLICT)
    	                .body("Stock already exists in watchlist");
    	    
    }
    Watchlist item1=new Watchlist();
    item1.setSymbol(dto.getSymbol());
    
        repository.save(item1);
        return ResponseEntity.ok("Added Sucessfully");
    }

    @Override
    public void removeFromWatchlist(Long id) {
        repository.deleteById(id);
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
public ResponseEntity<?> call(String symbol){
	  Watchlist item = new Watchlist();
      item.setSymbol(symbol);
      repository.save(item);
      return ResponseEntity.ok("Added to watchlist");
}

}

