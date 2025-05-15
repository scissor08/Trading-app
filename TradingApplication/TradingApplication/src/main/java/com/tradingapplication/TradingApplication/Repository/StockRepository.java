package com.tradingapplication.TradingApplication.Repository;

import com.tradingapplication.TradingApplication.Entity.*;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StockRepository extends JpaRepository<StockEntity, Long> {
    // Custom queries (if needed)
}

