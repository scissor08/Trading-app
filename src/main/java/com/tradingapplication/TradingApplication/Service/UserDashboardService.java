package com.tradingapplication.TradingApplication.Service;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

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
	UserDetailsRepository userDetailsRepository;
	
	@Override
	public String getUserDetail(UserLog user,Model model) {
		UserDetails userDetails=userDetailsRepository.findByUsername(user.getUsername()).orElseThrow(()->new DataNotFoundException("LoginPage"));
		UserAccountDetails userAccount=userDetails.getUserAccountDetails();
		model.addAttribute("userDetails",userDetails);
		model.addAttribute("userAccount",userAccount);
		return "UserProfile";
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
	public String getAccountBalance(UserLog user, Model model) {
		UserDetails userDetails=userDetailsRepository.findByUsername(user.getUsername()).orElseThrow(()->new DataNotFoundException("LoginPage"));
		model.addAttribute("balance", userDetails.getUserAccountDetails().getBalance());
		model.addAttribute("username", userDetails.getUsername());
		return "WalletPage";
	}

	@Override
	public UserDetails getDashboard(UserLog user,Model model) {
		UserDetails userDetails = userDetailsRepository.findByUsername(user.getUsername()).orElseThrow(()->new DataNotFoundException("LoginPage"));
		return userDetails;
	}

	@Override
	public String addAccountBalance(UserLog user, Model model, double cash) {
		UserDetails userdetails = userDetailsRepository.findByUsername(user.getUsername()).orElseThrow(()->new DataNotFoundException("LoginPage"));
		double oldbal = userdetails.getUserAccountDetails().getBalance();
		double newBal=oldbal+cash;
		userdetails.getUserAccountDetails().setBalance(newBal);
		userDetailsRepository.save(userdetails);
		model.addAttribute("balance",newBal);
		model.addAttribute("username", userdetails.getUsername());
		return "WalletPage";
	}


	
}
