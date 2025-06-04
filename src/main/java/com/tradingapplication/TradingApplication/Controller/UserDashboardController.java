package com.tradingapplication.TradingApplication.Controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Security.JwtUtil;
import com.tradingapplication.TradingApplication.Service.UserDashboardServiceInterface;
import com.tradingapplication.TradingApplication.Service.UserService;
import com.tradingapplication.TradingApplication.Service.WalletReportInterface;
import com.tradingapplication.TradingApplication.Service.WalletReportService;
import com.tradingapplication.TradingApplication.dto.WalReportRequestDTO;
import com.tradingapplication.TradingApplication.dto.WalResponseDTO;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
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
	WalletReportService  Wal;
	

	@Autowired
	JwtUtil jwtUtil;


	@GetMapping("/profile")
	public String getUserDetails(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication != null && authentication.isAuthenticated()) {
			String username = authentication.getName();
			return dashboardService.getUserDetail(username, model);
		}

		return "LoginPage";
	}

	@GetMapping("/dashboard")
	public String userDashboard(HttpServletRequest request, Model model) {
	    String token = null;

	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("jwt".equals(cookie.getName())) {
	                token = cookie.getValue();
	                break;
	            }
	        }
	    }

	    if (token != null && jwtUtil.validateToken(token, jwtUtil.extractUsername(token))) {
	        String username = jwtUtil.extractUsername(token);
	        log.info("Authenticated User: {}", username);

	        UserTable userdetails = dashboardService.getDashboard(username, model);
	        model.addAttribute("username", userdetails.getUsername());
	        model.addAttribute("balance", userdetails.getUserAccountDetails().getBalance());
	        model.addAttribute("stocks", dashboardService.getAllStockData());

	        return "UserDashboard"; 
	    }

	    return "LoginPage"; 
	}



	
	 @GetMapping("/watchlist")
	    public String showWatchlistPage() {
	        return "watchlist"; // maps to /WEB-INF/views/watchlist.jsp
	    }
	
	

	@GetMapping("/stock")
	public String getAllStocks(HttpSession session, Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if (user != null) {
			return "allStocks";
		}
		return "LoginPage";
	}

	@GetMapping("/wallet")
	public String getBalance(HttpSession session, Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication != null && authentication.isAuthenticated()) {
			String username = authentication.getName();
			return dashboardService.getAccountBalance(username, model);
		}

		return "LoginPage";
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
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication != null && authentication.isAuthenticated()) {
			String username = authentication.getName();
			double cashh = cash;
			return dashboardService.addAccountBalance(username, model, cashh);
		}

		return "LoginPage";
	}


	  @GetMapping("/walletRep")
	    public String showWallet(Model model) {
	        List<WalResponseDTO> transactions = Wal.getAllTransactions();
	        model.addAttribute("transactions", transactions);
	        return "WalletPage"; // wallet.jsp
	    }

	    @PostMapping("/wallet/add")
	    public String addMoney(@RequestParam double amount) {
	    	log.warn("******************"+amount);
	        Wal.addMoney(amount);
	        return "redirect:/WalletPage";
	    }

	    @PostMapping("/wallet/withdraw")
	    public String withdrawMoney(@RequestParam double amount) {
	        Wal.withdrawMoney(amount);
	        return "WalletPage";
	    }


}