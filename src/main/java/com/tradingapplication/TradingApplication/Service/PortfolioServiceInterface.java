package com.tradingapplication.TradingApplication.Service;

import java.util.List;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.dto.PortfolioResponseDTO;

public interface PortfolioServiceInterface {
	public List<PortfolioResponseDTO> getPortfolio(UserLog name);
	

}
