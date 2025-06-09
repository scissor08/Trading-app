package com.tradingapplication.TradingApplication.Service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.tradingapplication.TradingApplication.DateTime.WalletDTO;
import com.tradingapplication.TradingApplication.Entity.KycEntity;
import com.tradingapplication.TradingApplication.Entity.Stock;
import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Entity.Wallet;
import com.tradingapplication.TradingApplication.Repository.KycRepository;
import com.tradingapplication.TradingApplication.Repository.StockRepository;
import com.tradingapplication.TradingApplication.Repository.UserAccountDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.WalletReportRep;
import com.tradingapplication.TradingApplication.Security.AuthUtil;
import com.tradingapplication.TradingApplication.globalException.DataNotFoundException;
import com.tradingapplication.TradingApplication.globalException.KycNotUpdate;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserDashboardService implements UserDashboardServiceInterface {

	@Autowired
	UserDetailsRepository userDetailsRepository;
	@Autowired
	UserAccountDetailsRepository userAccountDetailsRepository;
	@Autowired
	KycRepository kycrepo;
	@Autowired
	AuthUtil authUtil;
    @Autowired
    private WalletReportRep transactionRepository;
	// Fetches user profile and account details
	@Override
	public String getUserDetail(String username, Model model) {
		
		UserTable userDetails = getUserDetailsByUsername(username);
		UserAccountDetails userAccount = userDetails.getUserAccountDetails();
		
		KycEntity kyc=kycrepo.findById((long) userDetails.getUserId()).orElseThrow(()->new KycNotUpdate("kyc not found"));
		
		if (userDetails.getProfileImage() != null) {
			String base64Image = Base64.getEncoder().encodeToString(userDetails.getProfileImage());
			model.addAttribute("profileImageBase64", base64Image);
		} else {
			model.addAttribute("profileImageBase64", null);
		}

		model.addAttribute("kyc", kyc);
		model.addAttribute("userDetails", userDetails);
		model.addAttribute("userAccount", userAccount);
		return "UserProfile";
	}

	@Override
	public UserTable getDashboard(String user, Model model) {
		return getUserDetailsByUsername(user);
	}

	@Override
	 public String addAccountBalance(UserTable userDetails,double amount, String username,String razorpayPaymentId,String razorpayOrderId,String razorpaySignature, Model model) {

        // 🔹 1. Update balance

        UserAccountDetails account = userDetails.getUserAccountDetails();
        account.setBalance(account.getBalance() + amount);
        userDetailsRepository.save(userDetails);

        // 🔹 2. Create wallet transaction
        Wallet tx = new Wallet();
        tx.setAmount(amount); // convert paise to INR
	    tx.setType("ADD");
	    tx.setStatus("SUCCESS");
	    tx.setUsername(username);
	    tx.setTimestamp(LocalDateTime.now());
	    tx.setRazorpayOrderId(razorpayOrderId);
	    tx.setRazorpayPaymentId(razorpayPaymentId);
	    tx.setRazorpaySignature(razorpaySignature);
	    tx.setUser(userDetails);

	    transactionRepository.save(tx);

        // 🔹 3. Convert all Wallet entities → WalletDTO list
        List<WalletDTO> transactions = transactionRepository.findAll()
                .stream()
                .map(WalletDTO::new)
                .collect(Collectors.toList());

        // 🔹 4. Put data on the model
        model.addAttribute("balance",     account.getBalance());
       // model.addAttribute("username",    userDetails.getUsername());
        model.addAttribute("transactions",transactionRepository.findAll());
  
        return "WalletPage";   // WalletPage.jsp
    }

	public double getMainBalance(HttpSession session) {
		UserTable getid = userDetailsRepository.findByUsername(authUtil.getCurrentUsername()).orElseThrow(()-> new DataNotFoundException("User not Found...."));	
		    	int id = getid.getUserId();
		        UserAccountDetails user = userAccountDetailsRepository.findById(id)
		                .orElseThrow(() -> new DataNotFoundException("User not found"));
		        double balance=user.getBalance();
		        return balance;
	}

	// Utility method to fetch user details or redirect
	private UserTable getUserDetailsByUsername(String username) {
		return userDetailsRepository.findByUsername(username).orElseThrow(() -> new DataNotFoundException("Arise"));
	}

	@Autowired
	private StockRepository stockRepository;

	@Override
	public List<Stock> getAllStockData() {
		return stockRepository.findAll();
	}

@Override
public String withdrawAccountBalance(String username, Model model, double amount) {
    UserTable userDetails =userDetailsRepository.findByUsername(username).orElseThrow(()->new DataNotFoundException("user not found"));
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
    
    Wallet tx = new Wallet();
    
    tx.setAmount(amount);
    tx.setUsername(userDetails.getUsername());
    tx.setType("WITHDRAW");
    if (amount > 0) {
        tx.setStatus("SUCCESS");
    } else {
        tx.setStatus("FAILED");
    }
    tx.setTimestamp(LocalDateTime.now());
    transactionRepository.save(tx);
    model.addAttribute("transactions",transactionRepository.findAll() );
    return "WalletPage";
}

@Override
public String getAccountBalance(String user, Model model) {
	UserTable userDetails = getUserDetailsByUsername(user);

	model.addAttribute("balance", userDetails.getUserAccountDetails().getBalance());
	model.addAttribute("username", userDetails.getUsername());

	return "WalletPage";
}

@Override
public String updateDp(MultipartFile profile, Model model) {
	UserTable user=userDetailsRepository.findByUsername(authUtil.getCurrentUsername()).orElseThrow(()->new DataNotFoundException("user not exist"));
	try {
		user.setProfileImage(profile.getBytes());

	} catch (IOException e) {
		e.printStackTrace();
	}
	userDetailsRepository.save(user);
	return "redirect:/profile";
}
	
}
