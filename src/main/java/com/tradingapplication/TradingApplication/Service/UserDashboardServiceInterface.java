package com.tradingapplication.TradingApplication.Service;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.tradingapplication.TradingApplication.Entity.Stock;
import com.tradingapplication.TradingApplication.Entity.UserTable;

import jakarta.mail.Multipart;
import jakarta.servlet.http.HttpSession;

public interface UserDashboardServiceInterface {

	List<Stock> getAllStockData();

	UserTable getDashboard(String user, Model model);

	String getUserDetail(String user, Model model);

    String getAccountBalance(String user, Model model);

    
	double getMainBalance(HttpSession session);

	String withdrawAccountBalance(String username, Model model, double amount);

	String updateDp(MultipartFile profile, Model model);


	String addAccountBalance(UserTable userDetails, double amount, String username, String razorpayPaymentId,
			String razorpayOrderId, String razorpaySignature, Model model);

	void updateWalletBalance(UserTable userDetails, double amount, String username, String razorpayPaymentId,
			String razorpayOrderId, String razorpaySignature);


}
