package com.tradingapplication.TradingApplication.Service;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.Stock;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.globalException.DataNotFoundException;

@Service
public class UserDashboardService implements UserDashboardServiceInterface {

	@Autowired
	UserDetailsRepository repository;
	
	@Override
	public UserDetails getUserDetail(UserLog user) {
		return repository.findByUserName(user.getUsername()).orElseThrow(()->new DataNotFoundException("Data Not Exist . . ."));	
	}

	@Override
	public Portfolio getPortfoliodetails(UserLog user) {

		return null;
	}

	@Override
	public Stock getStockDetails(UserLog user) {

		return null;
	}

	@Override
	public UserAccountDetails addAccountBalance(UserLog user, double cash) {
		// TODO Auto-generated method stub
		return null;
	}


	
}
