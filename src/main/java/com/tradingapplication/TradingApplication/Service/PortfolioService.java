package com.tradingapplication.TradingApplication.Service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Repository.PortfolioRepository;
import com.tradingapplication.TradingApplication.Repository.UserAccountDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Security.AuthUtil;
import com.tradingapplication.TradingApplication.dto.PortfolioResponseDTO;
import com.tradingapplication.TradingApplication.globalException.DataNotFoundException;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j

public class PortfolioService implements PortfolioServiceInterface {
	
	@Autowired
	PortfolioRepository portfolioRepository;
	@Autowired
	UserDetailsRepository userDetailsRepository;
	@Autowired
	UserAccountDetailsRepository userAccountDetailsRepository;
	@Autowired
	AuthUtil authUtil;
	
	public List<PortfolioResponseDTO> getPortfolio(HttpSession session) {

		UserTable getusername = userDetailsRepository.findByUsername(authUtil.getCurrentUsername()).orElseThrow(()-> new DataNotFoundException("user not found"));
		int id = getusername.getUserId();
//		UserAccountDetails user = userAccountDetailsRepository.findById(id)
//				.orElseThrow(()->new DataNotFoundException("User Not Found"));
		
		//UserDetails user = userDetailsRepository.findByUsername(name.getUsername()).orElseThrow(()->new DataNotFoundException("User Not Found"));
		List<Portfolio> portfolios = portfolioRepository.findByUser_Id(id);

		//List<Portfolio> portfolios = portfolioRepository.findByUser_Id(id);
		
		return portfolios.stream().map(Portfolio-> new PortfolioResponseDTO(Portfolio.getQuantity()
				,Portfolio.getSymbol(),Portfolio.getPrice(),
				Portfolio.getTrancationAmount())).collect(Collectors.toList());
			
	}
	

}
