package com.tradingapplication.TradingApplication.Service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Repository.PortfolioRepository;
import com.tradingapplication.TradingApplication.Repository.UserAccountDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.dto.PortfolioResponseDTO;
import com.tradingapplication.TradingApplication.globalException.DataNotFoundException;

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
	
<<<<<<< HEAD
	
	public List<PortfolioResponseDTO> getPortfolio(UserLog name) {
=======
	@Cacheable("fetchportfolio")
	public List<PortfolioResponseDTO> getPortfolio(int id) {
>>>>>>> 868543b170bb52600ff5d557bbfe50ade9850d8d
		
		
//		UserAccountDetails user = userAccountDetailsRepository.findById(id)
//				.orElseThrow(()->new DataNotFoundException("User Not Found"));
		
		UserDetails user = userDetailsRepository.findByUsername(name.getUsername()).orElseThrow(()->new DataNotFoundException("User Not Found"));
		List<Portfolio> portfolios = portfolioRepository.findByUser(user);

		//List<Portfolio> portfolios = portfolioRepository.findByUser_Id(id);
		
		return portfolios.stream().map(Portfolio-> new PortfolioResponseDTO(Portfolio.getQuantity()
				,Portfolio.getSymbol(),Portfolio.getPrice(),Portfolio.getTrancationAmount())).collect(Collectors.toList());
		
			
			
		
		
	}
	

}
