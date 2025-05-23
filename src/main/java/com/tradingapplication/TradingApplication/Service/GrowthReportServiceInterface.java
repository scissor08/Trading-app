package com.tradingapplication.TradingApplication.Service;

import java.util.List;

import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.Entity.GrowthReportEntity;

public interface GrowthReportServiceInterface {

	List<GrowthReportEntity> getGrowthReport(String username,Model model);
	


}
