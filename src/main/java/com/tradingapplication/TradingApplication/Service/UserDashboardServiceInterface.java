package com.tradingapplication.TradingApplication.Service;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.Stocks;
import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;

public interface UserDashboardServiceInterface {

	public UserDetails getUserDetail(UserLog user);

	public Portfolio getPortfoliodetails(UserLog user);

	public Stocks getStockDetails(UserLog user);

	public UserAccountDetails addAccountBalance(UserLog user, double cash);


}
