package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.StockDetails;
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
	public UserDetails getUserDetails(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			UserDetails userdetails = dashboardService.getUserDetail(user);
			model.addAttribute("username", userdetails.getUser().getUsername());
			model.addAttribute("email", userdetails.getEmail());
			model.addAttribute("mobile", userdetails.getMobile());
			model.addAttribute("dob", userdetails.getDateOfBirth());
			model.addAttribute("pan", userdetails.getPan());
			model.addAttribute("balance", userdetails.getUserAccountDetails().getBalance());
			return dashboardService.getUserDetail(user);
		}
		return dashboardService.getUserDetail(user);
	}
	
	@GetMapping("/dashBoard")
	public String userDashboard(HttpSession session,Model model) {
		
		UserLog user =(UserLog) session.getAttribute("userlog");
		UserDetails userdetails = new UserDetails();
		
		if(user!=null) {
			model.addAttribute("username", user.getUsername());
			model.addAttribute("balance", userdetails.getUserAccountDetails().getBalance());
			return "UserDashboard";
		}
		return"LoginPage";
		
	}
	
	@GetMapping("/portfolio")
	public Portfolio getUserPortfolio(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return dashboardService.getPortfoliodetails(user);
		}
		return dashboardService.getPortfoliodetails(user);
	}
	
	@GetMapping("/stocks")
	public StockDetails getAllStocks(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return dashboardService.getStockDetails(user);
		}
		return dashboardService.getStockDetails(user);
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
}