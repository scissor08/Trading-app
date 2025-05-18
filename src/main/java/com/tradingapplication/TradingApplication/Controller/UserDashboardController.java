package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Service.UserDashboardServiceInterface;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserDashboardController {

	@Autowired
	UserDashboardServiceInterface dashboardService;
	
	@GetMapping("/profile")
	public String getUserDetails(HttpSession session,Model model) {
		
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return dashboardService.getUserDetail(user, model);
		}
		return "LoginPage";
	}
	
	@GetMapping("/dashBoard")
	public String userDashboard(HttpSession session,Model model) {
		
		
		UserLog user =(UserLog) session.getAttribute("userlog");
		
		UserDetails userdetails=dashboardService.getDashboard(user, model);
		
		if(user!=null) {
			model.addAttribute("username", userdetails.getUsername());
			model.addAttribute("balance", userdetails.getUserAccountDetails().getBalance());
			return "UserDashboard";
		}
		return"LoginPage";
		
	}
	
	@GetMapping("/portfolio")
	public String getUserPortfolio(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			dashboardService.getPortfoliodetails(user);
		}
		return "LoginPage";
	}
	
	@GetMapping("/stocks")
	public String getAllStocks(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			dashboardService.getStockDetails(user);
		}
		return "LoginPage";
	}
	
	@GetMapping("/purchase")
	public String getPurchasePage(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return "";
		}
		return "LoginPage";
	}
	
	@GetMapping("/wallet")
	public String getAddBalancePage(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return "";
		}
		return "LoginPage";
	}
	
	@PostMapping("/wallet")
	public UserAccountDetails addBalance(double cash,HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return dashboardService.addAccountBalance(user,cash);
		}
		return dashboardService.addAccountBalance(user,cash);
	}
	
	@GetMapping("/logout")
	public String getLogot() {
		return "LoginPage";
	}
}