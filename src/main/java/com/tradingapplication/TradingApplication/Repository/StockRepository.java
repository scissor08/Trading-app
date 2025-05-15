package com.tradingapplication.TradingApplication.Repository;

import com.tradingapplication.TradingApplication.Entity.*;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface StockRepository extends JpaRepository<StockEntity, Long> {
	
	Optional<StockEntity> findBySymbol(String symbol);

	Optional<StockEntity> findById(Long id);
	Optional<StockEntity> findByQuantity (Long id);
}

