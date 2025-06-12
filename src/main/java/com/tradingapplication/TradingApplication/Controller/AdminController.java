package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tradingapplication.TradingApplication.Security.AuthUtil;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AuthUtil authUtil;
	
	@GetMapping("/dashboard")
	public String getAdminDashboard() {
		authUtil.getCurrentUsername();
		return "AdminDashboard";
	}
	
}
