package com.tradingapplication.TradingApplication.Service;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.User;
import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Repository.PortfolioRepository;
import com.tradingapplication.TradingApplication.Repository.UserAccountDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.dto.BuyResponseDTO;
import com.tradingapplication.TradingApplication.dto.BuySellStockRequestDTO;

@Service
public class BuySellService {

	@Autowired
	private UserDetailsRepository userRepository;
	@Autowired
	private PortfolioRepository portfolioRepository;
	@Autowired
	private UserAccountDetailsRepository userAccountDetailsRepository;

	public BuyResponseDTO buyRequest(String userEmail, BuySellStockRequestDTO buySellStockRequestDTO) {

		final String TsType = "Buy";
		Portfolio portfolio = new Portfolio();
		//UserAccountDetails userAccountDetails = new UserAccountDetails();
		
		User user = userRepository.findByEmail(userEmail).orElseThrow(() -> new RuntimeException("User not found")); // Fetch the use detail
		 UserAccountDetails userAccountDetails = user.getUserAccountDetails();
																													

		if (userAccountDetails == null) {
			throw new RuntimeException("User account details not found");
		}

	    
		portfolio.setTransactionType(TsType);
		
		double transactionAmount = portfolio.getQuantity() * portfolio.getPrice();

		double walletbalance = userAccountDetails.getBalance();

		if (transactionAmount > walletbalance) {
			throw new RuntimeException("Insufficient balance");

		}
		userAccountDetails.setBalance(walletbalance - transactionAmount);

		portfolio.setUser(user);
		userAccountDetailsRepository.save(userAccountDetails);

		
		portfolioRepository.save(portfolio);

		BuyResponseDTO response = new BuyResponseDTO();
		response.setStatus("success");
		response.setMessage("Buy transaction successful.");
		response.setRemainingBalance(userAccountDetails.getBalance());
		response.setTransactionAmount(transactionAmount);

		return response;

	}
}
