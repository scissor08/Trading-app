package com.tradingapplication.TradingApplication.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tradingapplication.TradingApplication.Entity.Portfolio;

public interface PortfolioRepository extends JpaRepository<Portfolio,Integer>{

}
