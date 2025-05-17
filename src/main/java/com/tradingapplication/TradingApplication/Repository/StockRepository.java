package com.tradingapplication.TradingApplication.Repository;

import com.tradingapplication.TradingApplication.Entity.*; 

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface StockRepository extends JpaRepository<Stock, Long> {
	
	Optional<Stock> findBySymbol(String symbol);

//	Optional<Stock> findById(Long id);
//	Optional<Stock> findByQuantity (Long id);
}

