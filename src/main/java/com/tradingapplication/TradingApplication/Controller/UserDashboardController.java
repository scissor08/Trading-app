package com.tradingapplication.TradingApplication.Controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Entity.Wallet;
import com.tradingapplication.TradingApplication.Security.AuthUtil;
import com.tradingapplication.TradingApplication.Security.JwtUtil;
import com.tradingapplication.TradingApplication.Service.UserDashboardServiceInterface;
import com.tradingapplication.TradingApplication.Service.UserService;
import com.tradingapplication.TradingApplication.Service.WalletReportService;

import jakarta.servlet.http.HttpSession;
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
	WalletReportService Wal;

	@Autowired
	JwtUtil jwtUtil;
	@Autowired
	AuthUtil authUtil;

	@GetMapping("/profile")
	public String getUserDetails(Model model) {
		 String username = authUtil.getCurrentUsername();
			return dashboardService.getUserDetail(username, model);
	}

	@GetMapping("/dashboard")
	public String userDashboard(Model model) {
	    authUtil.getCurrentUsername();
	    model.addAttribute("stocks", dashboardService.getAllStockData());
	    return "UserDashboard";
	}

	@GetMapping("/watchlist")
	public String showWatchlistPage() {
		return "watchlist"; 
	}

	@GetMapping("/stock")
	public String getAllStocks(HttpSession session, Model model) {
		 authUtil.getCurrentUsername();
			return "allStocks";
	}

	@GetMapping("/wallet")
	public String getBalance(HttpSession session, Model model) {
		 String username = authUtil.getCurrentUsername();
			return dashboardService.getAccountBalance(username, model);
	}

	@PostMapping("/withdraw")
	public String withdrawBalance(HttpSession session, Model model, @RequestParam Double amount) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if (user != null) {
			return dashboardService.withdrawAccountBalance(user, model, amount);
		}
		return "LoginPage";
	}

	@PostMapping("/add")
	public String addBalance(HttpSession session, Model model, @RequestParam Double cash) {
		 String username = authUtil.getCurrentUsername();
			double cashh = cash;
			return dashboardService.addAccountBalance(username, model, cashh);
		}
	
	@GetMapping("/walletRep")
	public String showWallet(Model model) {
		List<Wallet> transactions = Wal.getAllTransactions();
		model.addAttribute("transactions", transactions);
		return "WalletPage"; // wallet.jsp
	}

}