package com.tradingapplication.TradingApplication.Repository;

import com.tradingapplication.TradingApplication.Entity.*; 

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface StockRepository extends JpaRepository<StockDetails, Long> {
	
	Optional<StockDetails> findBySymbol(String symbol);

	Optional<StockDetails> findById(Long id);
	Optional<StockDetails> findByQuantity (Long id);
}

