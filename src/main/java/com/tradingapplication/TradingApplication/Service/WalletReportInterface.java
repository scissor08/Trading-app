package com.tradingapplication.TradingApplication.Service;

import java.util.List;

import com.tradingapplication.TradingApplication.Entity.Wallet;

public interface WalletReportInterface {
	  void addMoney(double amount);
	    void withdrawMoney(double amount);
	    List<Wallet> getAllTransactions();
}
