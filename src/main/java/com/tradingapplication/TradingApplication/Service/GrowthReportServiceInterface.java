package com.tradingapplication.TradingApplication.Service;

import java.io.PrintWriter;
import java.util.List;

import com.tradingapplication.TradingApplication.Entity.GrowthReportEntity;

public interface GrowthReportServiceInterface {

	List<GrowthReportEntity> getGrowthReport(String username);

//	void exportCsv(PrintWriter writer);

	void exportCsv(PrintWriter writer, String username);

}
