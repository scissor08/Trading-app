package com.tradingapplication.TradingApplication.Controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.tradingapplication.TradingApplication.Entity.GrowthReportEntity;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Security.JwtUtil;
import com.tradingapplication.TradingApplication.Service.GrowthReportServiceInterface;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class GrowthReportController {
	
	@Autowired
	GrowthReportServiceInterface growthReport;
	@Autowired
	JwtUtil jwtUtil;
	
	@GetMapping("/growthreport")
	public String getGrowth(HttpServletRequest request, Model model) {
	    String token = null;

	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("jwt")) {
	                token = cookie.getValue();
	            }
	        }
	    }

	    if (token == null) {
	        String authHeader = request.getHeader("Authorization");
	        if (authHeader != null && authHeader.startsWith("Bearer ")) {
	            token = authHeader.substring(7);
	        }
	    }

	    String username = null;
	    if (token != null && jwtUtil.validateToken(token)) { 
	        username = jwtUtil.extractUsername(token); 
	    }

	    if (username != null) {
	        List<GrowthReportEntity> growth = growthReport.getGrowthReport(username);
	        model.addAttribute("report", growth);
	        return "GrowthReportPage";
	    } else {
	        return "redirect:/arise/login"; 
	    }
	}
	
//	@GetMapping("/growthreport")
//	public String getGrowth(HttpSession session,Model model) {
//		UserLog userlog=(UserLog) session.getAttribute("userlog");
//		String username=userlog.getUsername();
//		List<GrowthReportEntity> growth=growthReport.getGrowthReport(username);
//		model.addAttribute("report", growth);
//		return "GrowthReportPage";
//	}

    @GetMapping("/download/csv")
    public void downloadCsv(HttpServletResponse response) throws IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=growth_report.csv");
        growthReport.exportCsv(response.getWriter());
    }

}
