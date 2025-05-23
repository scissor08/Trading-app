package com.tradingapplication.TradingApplication.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.tradingapplication.TradingApplication.Entity.GrowthReportEntity;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Service.GrowthReportServiceInterface;

import jakarta.servlet.http.HttpSession;

@Controller
public class GrowthReportController {
	
	@Autowired
	GrowthReportServiceInterface growthReport;
	
	@GetMapping("/growthreport")
	public String getGrowth(HttpSession session,Model model) {
		UserLog userlog=(UserLog) session.getAttribute("userlog");
		String username=userlog.getUsername();
		List<GrowthReportEntity> growth=growthReport.getGrowthReport(username,model);
		model.addAttribute("report", growth);
		return "GrowthReportPage";
		
	}

}
