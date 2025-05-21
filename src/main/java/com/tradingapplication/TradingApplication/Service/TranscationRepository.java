package com.tradingapplication.TradingApplication.Service;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tradingapplication.TradingApplication.Entity.TransactionBuySell;



public interface TranscationRepository extends JpaRepository<TransactionBuySell,Integer>{

}
