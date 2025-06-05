package com.tradingapplication.TradingApplication.Service;

import java.util.List;

import com.tradingapplication.TradingApplication.Entity.Wallet;
import com.tradingapplication.TradingApplication.dto.WalReportRequestDTO;
import com.tradingapplication.TradingApplication.dto.WalResponseDTO;

public interface WalletReportInterface {
	  void addMoney(double amount);
	    void withdrawMoney(double amount);
	    List<Wallet> getAllTransactions();
}
