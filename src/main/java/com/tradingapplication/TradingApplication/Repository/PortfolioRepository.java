package com.tradingapplication.TradingApplication.Repository;

 

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.Stock;
import com.tradingapplication.TradingApplication.Entity.UserDetails;

public interface PortfolioRepository extends JpaRepository<Portfolio,Integer>{
	
	//Optional<List<Portfolio>>findAllBySymbol(String Symbol);
	Optional<Portfolio> findByUserAndStocks(UserDetails user, Stock stocks);


}
