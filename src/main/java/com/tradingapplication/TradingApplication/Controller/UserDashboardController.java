package com.tradingapplication.TradingApplication.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Service.UserDashboardServiceInterface;
import com.tradingapplication.TradingApplication.Service.UserService;
import com.tradingapplication.TradingApplication.Service.WalletReportInterface;
import com.tradingapplication.TradingApplication.Service.WalletReportService;
import com.tradingapplication.TradingApplication.dto.WalReportRequestDTO;
import com.tradingapplication.TradingApplication.dto.WalResponseDTO;

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
	
	@GetMapping("/profile")
	public String getUserDetails(HttpSession session,Model model) {
		
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return dashboardService.getUserDetail(user, model);
		}
		return "LoginPage";
	}
	
	@GetMapping("/dashboard")
	public String userDashboard(HttpSession session, Model model) {
		
		UserLog user = (UserLog) session.getAttribute("userlog");

	    if (user != null) {
	    	UserTable userdetails = dashboardService.getDashboard(user, model);
	        model.addAttribute("username", userdetails.getUsername());
	        model.addAttribute("balance", userdetails.getUserAccountDetails().getBalance());
	        model.addAttribute("stocks", dashboardService.getAllStockData()); // Set stocks for JSP
	        return "UserDashboard"; // Looks for UserDashboard.jsp
	    }
		
	    return "LoginPage";
	}

	@GetMapping("/portfolio")
	public String getUserPortfolio(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			dashboardService.getPortfoliodetails(user);
		}
		return "LoginPage";
	}
	
	 @GetMapping("/watchlist")
	    public String showWatchlistPage() {
	        return "watchlist"; // maps to /WEB-INF/views/watchlist.jsp
	    }
	
	
	@GetMapping("/stock")
	public String getAllStocks(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return "allStocks";
		}
		return "LoginPage";
	}
	
	@GetMapping("/wallet")
	public String getBalance(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return dashboardService.getAccountBalance(user,model);
		}
		return "LoginPage";
	}
	
	
	@GetMapping("/addbalance")
	public String addBalancePage(HttpSession session) {
	UserLog user = (UserLog) session.getAttribute("userlog");
	if(user!=null) {
		return "AddBalance";
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
	public String addBalance(HttpSession session,Model model,@RequestParam Double cash) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			double cashh = cash;
			return dashboardService.addAccountBalance(user,model,cashh);
		}
		
		return "LoginPage";
	}
	
	
	@GetMapping("/logout")
	public String getLogot(HttpSession session) {
		session.invalidate();
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