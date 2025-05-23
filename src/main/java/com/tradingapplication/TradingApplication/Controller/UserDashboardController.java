package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Service.UserDashboardServiceInterface;
import com.tradingapplication.TradingApplication.Service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class UserDashboardController {

	@Autowired
	UserDashboardServiceInterface dashboardService;
	@Autowired
	UserService service;
	
	@GetMapping("/profile")
	public String getUserDetails(HttpSession session,Model model) {
		
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return dashboardService.getUserDetail(user, model);
		}
		return "LoginPage";
	}
	
	@GetMapping("/dashboard")
	public String userDashboard(UserLog userlog,HttpSession session, Model model) {
		
		UserLog user = (UserLog) session.getAttribute("userlog");

	    if (user != null) {
	        UserDetails userdetails = dashboardService.getDashboard(user, model);
	        model.addAttribute("username", userdetails.getUsername());
	        model.addAttribute("balance", userdetails.getUserAccountDetails().getBalance());
	        model.addAttribute("stocks", dashboardService.getAllStockData()); // Set stocks for JSP
	        return "UserDashboard"; // Looks for UserDashboard.jsp
	    }
		
	    return "redirect:/LoginPage";
	}


	
	@GetMapping("/portfolio")
	public String getUserPortfolio(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			dashboardService.getPortfoliodetails(user);
		}
		return "LoginPage";
	}
	
	
	@GetMapping("/stock")
	public String getAllStocks(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return "allStocks";
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
	public String getBalance(HttpSession session,Model model) {
		UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return dashboardService.getAccountBalance(user,model);
		}
		return dashboardService.getAccountBalance(user,model);
	}
	
	
	@GetMapping("/addbalance")
	public String addBalancePage(HttpSession session) {
	UserLog user = (UserLog) session.getAttribute("userlog");
	if(user!=null) {
		return "AddBalance";
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
		
		return null;
	}
	
	@GetMapping("/logout")
	public String getLogot(HttpSession session) {
		session.invalidate();
		return "LoginPage";
	}
}