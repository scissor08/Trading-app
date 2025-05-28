package com.tradingapplication.TradingApplication.Service;

import java.io.PrintWriter;
import java.util.List;

import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.Entity.GrowthReportEntity;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;

public interface GrowthReportServiceInterface {

	List<GrowthReportEntity> getGrowthReport(String username,Model model);

	void exportCsv(PrintWriter writer);

}
