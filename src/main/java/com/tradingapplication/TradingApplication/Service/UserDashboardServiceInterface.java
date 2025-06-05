package com.tradingapplication.TradingApplication.Service;

import java.util.List;

import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.Entity.Stock;
import com.tradingapplication.TradingApplication.Entity.UserTable;

import jakarta.servlet.http.HttpSession;

public interface UserDashboardServiceInterface {

	List<Stock> getAllStockData();

	UserTable getDashboard(String user, Model model);

	String getUserDetail(String user, Model model);

	String getAccountBalance(String user, Model model);

	String addAccountBalance(String user, Model model, double cash);
	double getMainBalance(HttpSession session);

}
