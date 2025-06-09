package com.tradingapplication.TradingApplication.Service;


import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Entity.Watchlist;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.WatchlistRepository;
import com.tradingapplication.TradingApplication.Security.AuthUtil;
import com.tradingapplication.TradingApplication.dto.WatchlistRequestDTO;
import com.tradingapplication.TradingApplication.dto.WatchlistResponseDTO;
import com.tradingapplication.TradingApplication.globalException.DataNotFoundException;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class WatchlistService implements WatchlistServiceInterface {

    @Autowired
    private WatchlistRepository repository;
    @Autowired 
    private UserDetailsRepository userDetailsRepository;
    @Autowired
	AuthUtil authUtil;


  

    @Override
    public List<WatchlistResponseDTO> getAllWatchlistItems() {
    	UserTable getusername = userDetailsRepository.findByUsername(authUtil.getCurrentUsername()).orElseThrow(()-> new DataNotFoundException("user not found"));
		int id = getusername.getUserId();
        return repository.findAllByUserId(id).stream().map(this::mapToDTO).collect(Collectors.toList());
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

    @Override
    public ResponseEntity<?> addToWatchlist(WatchlistRequestDTO dto) {
        // Step 1: Get logged-in user
        UserTable user = userDetailsRepository.findByUsername(authUtil.getCurrentUsername())
                .orElseThrow(() -> new DataNotFoundException("User not found"));
        int userId = user.getUserId();

        // Step 2: Check if the stock already exists for this user
        Optional<Watchlist> existingItem = repository.findByUserIdAndSymbol(userId, dto.getSymbol());
        if (existingItem.isPresent()) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                                 .body("Stock already exists in your watchlist");
        }

        // Step 3: Create and save new Watchlist item
        Watchlist newItem = new Watchlist();
        newItem.setUser(user); // ✅ CORRECT: set user object, not userId
        newItem.setSymbol(dto.getSymbol());
        repository.save(newItem);

        return ResponseEntity.ok("Added Successfully");
    }


    
    public boolean removeFromWatchlist(int id) {
        if (repository.existsById(id)) {
            repository.deleteById(id);
            return true;
        }
        return false;
    }

	
}