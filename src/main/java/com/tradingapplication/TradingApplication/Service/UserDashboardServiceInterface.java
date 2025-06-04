package com.tradingapplication.TradingApplication.Service;

import java.util.List; 

import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.Stock;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Entity.UserTable;

public interface UserDashboardServiceInterface {



	List<Stock> getAllStockData();

	
    Portfolio getPortfoliodetails(UserLog user);

    Stock getStockDetails(UserLog user);

    UserTable getDashboard(UserLog user, Model model);

    String getUserDetail(UserLog user, Model model);

    String getAccountBalance(UserLog user, Model model);

    String addAccountBalance(UserLog user, Model model, double cash);	
    String withdrawAccountBalance(UserLog user, Model model, double amount);

}
