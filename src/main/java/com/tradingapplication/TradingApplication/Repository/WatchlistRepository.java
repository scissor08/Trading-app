package com.tradingapplication.TradingApplication.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tradingapplication.TradingApplication.Entity.Watchlist;

import java.util.Optional;

public interface WatchlistRepository extends JpaRepository<Watchlist, Long> {
    Optional<Watchlist> findBySymbol(String symbol);
    
}

