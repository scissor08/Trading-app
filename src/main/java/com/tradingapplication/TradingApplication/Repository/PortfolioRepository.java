package com.tradingapplication.TradingApplication.Repository;

 

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.Stock;
import com.tradingapplication.TradingApplication.Entity.UserTable;

public interface PortfolioRepository extends JpaRepository<Portfolio,Integer>{
		
	List<Portfolio> findByUser(UserTable user);
	@Query(value="select * from portfolio where user_Id = ?1 ", nativeQuery =  true )
	List<Portfolio> findByUser_Id(int id);
	Optional<Portfolio> findByUserAndStocks(UserTable user, Stock stocks);
    List<Portfolio> findByUsername(String username);

}
