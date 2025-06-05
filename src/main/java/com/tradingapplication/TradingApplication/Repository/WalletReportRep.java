package com.tradingapplication.TradingApplication.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tradingapplication.TradingApplication.Entity.WalletReport;

public interface WalletReportRep extends JpaRepository<WalletReport, Long>  {
	  List<WalletReport> findAllByOrderByTimestampDesc();
}
