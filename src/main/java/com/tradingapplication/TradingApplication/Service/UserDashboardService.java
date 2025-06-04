package com.tradingapplication.TradingApplication.Service;

import java.util.Base64; 
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.Stock;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Repository.StockRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.globalException.DataNotFoundException;

@Service
public class UserDashboardService implements UserDashboardServiceInterface {

	@Autowired
	UserDetailsRepository userDetailsRepository;
//	
//	@Override
//	public String getUserDetail(UserLog user,Model model) {
//		UserDetails userDetails=userDetailsRepository.findByUsername(user.getUsername()).orElseThrow(()->new DataNotFoundException("LoginPage"));
//		UserAccountDetails userAccount=userDetails.getUserAccountDetails();
//		model.addAttribute("userDetails",userDetails);
//		model.addAttribute("userAccount",userAccount);
//		return "UserProfile";
//	}
//
//	@Override
//	public Portfolio getPortfoliodetails(UserLog user) {
//
//		return null;
//	}
//
//	@Override
//	public Stock getStockDetails(UserLog user) {
//
//		return null;
//	}
//
//	@Override
//	public String getAccountBalance(UserLog user, Model model) {
//		UserDetails userDetails=userDetailsRepository.findByUsername(user.getUsername()).orElseThrow(()->new DataNotFoundException("LoginPage"));
//		model.addAttribute("balance", userDetails.getUserAccountDetails().getBalance());
//		model.addAttribute("username", userDetails.getUsername());
//		return "WalletPage";
//	}
//
//	@Override
//	public UserDetails getDashboard(UserLog user,Model model) {
//		UserDetails userDetails = userDetailsRepository.findByUsername(user.getUsername()).orElseThrow(()->new DataNotFoundException("LoginPage"));
//		return userDetails;
//	}
//
//	@Override
//	public String addAccountBalance(UserLog user, Model model, double cash) {
//		UserDetails userdetails = userDetailsRepository.findByUsername(user.getUsername()).orElseThrow(()->new DataNotFoundException("LoginPage"));
//		double oldbal = userdetails.getUserAccountDetails().getBalance();
//		double newBal=oldbal+cash;
//		userdetails.getUserAccountDetails().setBalance(newBal);
//		userDetailsRepository.save(userdetails);
//		model.addAttribute("balance",newBal);
//		model.addAttribute("username", userdetails.getUsername());
//		return "WalletPage";
//	}




    // Fetches user profile and account details
    @Override
    public String getUserDetail(UserLog user, Model model) {
    	UserTable userDetails = getUserDetailsByUsername(user);
        UserAccountDetails userAccount = userDetails.getUserAccountDetails();
        if (userDetails.getProfileImage() != null) {
            String base64Image = Base64.getEncoder().encodeToString(userDetails.getProfileImage());
            model.addAttribute("profileImageBase64", base64Image);
        } else {
            model.addAttribute("profileImageBase64", null);
        }
        
        model.addAttribute("userDetails", userDetails);
        model.addAttribute("userAccount", userAccount);

        return "UserProfile";
    }

    // Placeholder - implement logic as needed
    @Override
    public Portfolio getPortfoliodetails(UserLog user) {
        return null;
    }

    // Placeholder - implement logic as needed
    @Override
    public Stock getStockDetails(UserLog user) {
        return null;
    }

    // Fetch and display account balance
    @Override
    public String getAccountBalance(UserLog user, Model model) {
    	UserTable userDetails = getUserDetailsByUsername(user);

        model.addAttribute("balance", userDetails.getUserAccountDetails().getBalance());
        model.addAttribute("username", userDetails.getUsername());

        return "WalletPage";
    }

    // Get full user dashboard details
    @Override
    public UserTable getDashboard(UserLog user, Model model) {
        return getUserDetailsByUsername(user);
    }

    // Add balance to user account and return updated wallet page
    @Override
    public String addAccountBalance(UserLog user, Model model, double cash) {
    	UserTable userDetails = getUserDetailsByUsername(user);

        UserAccountDetails account = userDetails.getUserAccountDetails();
        account.setBalance(account.getBalance() + cash);

        userDetailsRepository.save(userDetails);

        model.addAttribute("balance", account.getBalance());
        model.addAttribute("username", userDetails.getUsername());

        return "WalletPage";
    }

    // Utility method to fetch user details or redirect
    private UserTable getUserDetailsByUsername(UserLog user) {
        return userDetailsRepository.findByUsername(user.getUsername())
                .orElseThrow(() -> new DataNotFoundException("LoginPage"));
    }
    @Autowired
    private StockRepository stockRepository;

@Override
public List<Stock> getAllStockData() {
    return stockRepository.findAll();
}

@Override
public String withdrawAccountBalance(UserLog user, Model model, double amount) {
    UserTable userDetails = getUserDetailsByUsername(user);
    UserAccountDetails account = userDetails.getUserAccountDetails();

    double currentBalance = account.getBalance();

    if (amount <= 0 || amount > currentBalance) {
        model.addAttribute("error", "Invalid withdrawal amount");
        model.addAttribute("balance", currentBalance);
        model.addAttribute("username", userDetails.getUsername());
        return "WalletPage"; // or a separate error page if desired
    }

    account.setBalance(currentBalance - amount);
    userDetailsRepository.save(userDetails);

    model.addAttribute("balance", account.getBalance());
    model.addAttribute("username", userDetails.getUsername());

    return "WalletPage";
}

	
}
