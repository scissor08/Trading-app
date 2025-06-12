package com.tradingapplication.TradingApplication.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tradingapplication.TradingApplication.Entity.Wallet;

public interface WalletReportRep extends JpaRepository<Wallet, Long>  {
	  List<Wallet> findAll();
	  List<Wallet> findByUsernameOrderByTimestampDesc(String username);

}
