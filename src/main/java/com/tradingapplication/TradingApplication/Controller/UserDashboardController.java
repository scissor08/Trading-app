package com.tradingapplication.TradingApplication.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tradingapplication.TradingApplication.Security.AuthUtil;
import com.tradingapplication.TradingApplication.Security.JwtUtil;
import com.tradingapplication.TradingApplication.Service.IndexService;
import com.tradingapplication.TradingApplication.Service.PaymentService;
import com.tradingapplication.TradingApplication.Service.UserDashboardServiceInterface;
import com.tradingapplication.TradingApplication.Service.UserService;
import com.tradingapplication.TradingApplication.dto.IndexDTO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping
@Slf4j
public class UserDashboardController {

	@Autowired
	UserDashboardServiceInterface dashboardService;
	@Autowired
	UserService service;
	@Autowired
	PaymentService paymentService;

	  @Autowired
	    private IndexService indexService;
	@Autowired
	JwtUtil jwtUtil;
	@Autowired
	AuthUtil authUtil;

	@GetMapping("/profile")
	public String getUserDetails(Model model) {
		 String username = authUtil.getCurrentUsername();
			return dashboardService.getUserDetail(username, model);
	}
	
	@PostMapping("/dpupdate")
	public String dpUpdate(@RequestParam MultipartFile profile,Model model) {
		return dashboardService.updateDp(profile,model);
	}

	@GetMapping("/dashboard")
	public String userDashboard(Model model) {
	    authUtil.getCurrentUsername();
	    model.addAttribute("stocks", dashboardService.getAllStockData());
	    try {
	    List<IndexDTO> indices = indexService.getLiveIndices();
        model.addAttribute("indices", indices);

        System.out.println("Indices: " + indices);
        
    } catch (Exception e) {
        e.printStackTrace();
        // Add empty list if error occurs
        model.addAttribute("indices", java.util.Collections.emptyList());
    }
    
	    
       
	    
	    return "UserDashboard";
	}

	@GetMapping("/watchlist")
	public String showWatchlistPage() {
		return "watchlist"; 
	}

	@GetMapping("/stock")
	public String getAllStocks(Model model) {
		 authUtil.getCurrentUsername();
			return "allStocks";
	}

	@GetMapping("/wallet")
	public String getBalance(Model model) {
	    String username = authUtil.getCurrentUsername();
	    
	    // Add balance/transaction data using your existing logic
	    String view = dashboardService.getAccountBalance(username, model);
	    
	    // Inject Razorpay public key into the model for the JSP
	    
	    model.addAttribute("razorpayKey", paymentService.getRazorpayKey());
	    

	    return view;
	}


	@PostMapping("/withdraw")
	public String withdrawBalance(Model model, @RequestParam Double amount) {
		 String username = authUtil.getCurrentUsername();
			return dashboardService.withdrawAccountBalance(username, model, amount);
		
	}

//	@PostMapping("/add")
//	public String addBalance(Model model, @RequestParam Double cash) {
//		 String username = authUtil.getCurrentUsername();
//			double cashh = cash;
//			return dashboardService.addAccountBalance(username, model, cashh);
//		}
	
//	@GetMapping("/walletRep")
//	public String showWallet(Model model) {
//		List<Wallet> transactions = .getAllTransactions();
//		model.addAttribute("transactions", transactions);
//		return "WalletPage"; // wallet.jsp
//	}

}