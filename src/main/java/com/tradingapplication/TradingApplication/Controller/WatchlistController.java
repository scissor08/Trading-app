package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.tradingapplication.TradingApplication.Entity.Watchlist;
import com.tradingapplication.TradingApplication.Service.WatchlistService;
import com.tradingapplication.TradingApplication.Service.WatchlistServiceInterface;
import com.tradingapplication.TradingApplication.dto.WatchlistRequestDTO;
import com.tradingapplication.TradingApplication.dto.WatchlistResponseDTO;

import java.util.List;
import java.util.Optional;
@RestController
@RequestMapping("/api/watchlist")
public class WatchlistController {

    @Autowired
    private WatchlistServiceInterface service;

    @Autowired
    private WatchlistService watchlistService;
    @GetMapping
    public ResponseEntity<List<WatchlistResponseDTO>> getWatchlist() {
        List<WatchlistResponseDTO> items = service.getAllWatchlistItems();
        return ResponseEntity.ok(items);
    }
    @DeleteMapping("/remove/{id}")
    public ResponseEntity<?> deleteStock(@PathVariable int id) {
        boolean removed = watchlistService.removeFromWatchlist(id);
      
        if (removed) {
        	  return ResponseEntity.ok().body("Deleted"); // 204 No Content
        } else {
            return ResponseEntity.notFound().build(); // 404 Not Found
        }
    }
    
    

    @PostMapping("/add")
    public ResponseEntity<?> add(@RequestBody WatchlistRequestDTO dto) {
        return service.addToWatchlist(dto);
    }
}
