package com.tradingapplication.TradingApplication.Controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.tradingapplication.TradingApplication.Entity.GrowthReportEntity;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Security.AuthUtil;
import com.tradingapplication.TradingApplication.Security.JwtUtil;
import com.tradingapplication.TradingApplication.Service.GrowthReportServiceInterface;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class GrowthReportController {
	
	@Autowired
	GrowthReportServiceInterface growthReport;
	@Autowired
	JwtUtil jwtUtil;
	@Autowired
	AuthUtil authUtil;
	
	@GetMapping("/growthreport")
	public String getGrowth(HttpSession session,Model model) {
		
		String username=authUtil.getCurrentUsername();
		List<GrowthReportEntity> growth=growthReport.getGrowthReport(username);
		model.addAttribute("report", growth);
		return "GrowthReportPage";
	}

    @GetMapping("/download/csv")
    public void downloadCsv(HttpServletResponse response) throws IOException {
    	String username=authUtil.getCurrentUsername();
    	response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=growth_report.csv");
        growthReport.exportCsv(response.getWriter(),username);
    }

}
