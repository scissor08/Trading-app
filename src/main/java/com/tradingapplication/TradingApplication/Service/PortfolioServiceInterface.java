package com.tradingapplication.TradingApplication.Service;

import java.util.List;

import com.tradingapplication.TradingApplication.dto.PortfolioResponseDTO;

import jakarta.servlet.http.HttpSession;

public interface PortfolioServiceInterface {
	public List<PortfolioResponseDTO> getPortfolio(HttpSession session);
	

}
