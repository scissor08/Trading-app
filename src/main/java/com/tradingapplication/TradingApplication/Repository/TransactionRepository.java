package com.tradingapplication.TradingApplication.Repository;

import org.springframework.data.jpa.repository.JpaRepository; 
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.TransactionBuySell;


@Repository
public interface TransactionRepository extends JpaRepository<TransactionBuySell,Integer>{
	

}
