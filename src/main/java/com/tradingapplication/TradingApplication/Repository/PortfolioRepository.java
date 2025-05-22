package com.tradingapplication.TradingApplication.Repository;

 

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.Stock;
import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserDetails;

public interface PortfolioRepository extends JpaRepository<Portfolio,Integer>{
	
	//Optional<List<Portfolio>>findAllByUserId(int userId);
	
	//Optional<List<Portfolio>> findByUser_Id(int userId);
	//Optional<List<Portfolio>> findByUserId(int userId);
	
	List<Portfolio> findByUser(UserDetails user);



	Optional<Portfolio> findByUserAndStocks(UserDetails user, Stock stocks);


}
