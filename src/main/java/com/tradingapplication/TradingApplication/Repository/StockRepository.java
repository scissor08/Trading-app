package com.tradingapplication.TradingApplication.Repository;

import com.tradingapplication.TradingApplication.Entity.Stock;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface StockRepository extends JpaRepository<Stock, Long> {
    Optional<Stock> findBySymbol(String symbol);
    Optional<Stock> findById(Long id);
    
}
