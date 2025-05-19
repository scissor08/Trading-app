package com.tradingapplication.TradingApplication.Service;

import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.Stock;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;

public interface UserDashboardServiceInterface {


	public Portfolio getPortfoliodetails(UserLog user);

	public Stock getStockDetails(UserLog user);

	public UserDetails getDashboard(UserLog user, Model model);

	String getUserDetail(UserLog user, Model model);

	public String getAccountBalance(UserLog user, Model model);

	public String addAccountBalance(UserLog user, Model model, double cash);


}
