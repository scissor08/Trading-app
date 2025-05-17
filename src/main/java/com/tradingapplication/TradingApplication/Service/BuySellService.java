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
		User user = userRepository.findByEmail(userEmail).orElseThrow(() -> new RuntimeException("User not found")); // Fetch
																														// the
		Portfolio portfolio = new Portfolio(); // user
<<<<<<< HEAD
		UserDetails userDetails = user.getUserdetails();

		
=======
		
		UserAccountDetails userAccountDetails = user.getUserAccountDetails();
>>>>>>> 8c7e053acf4a808e72c7cde4d2079dcdf265dd9b
		if (userAccountDetails == null) {
			throw new RuntimeException("User account details not found");
		}

		double transactionAmount = portfolio.getQuantity() * portfolio.getPrice();

		double walletbalance = userAccountDetails.getBalance();

		if (transactionAmount > walletbalance) {
			throw new RuntimeException("Insufficient balance");

		}
		userAccountDetails.setBalance(walletbalance - transactionAmount);

		userAccountDetailsRepository.save(userAccountDetails);

		portfolio.setPrice(buySellStockRequestDTO.getPrice());
		portfolio.setQuantity(buySellStockRequestDTO.getQuantity());
		portfolio.setTransactionType(TsType);
		portfolio.setUser(user);
		portfolioRepository.save(portfolio);

		BuyResponseDTO response = new BuyResponseDTO();
		response.setStatus("success");
		response.setMessage("Buy transaction successful.");
		response.setRemainingBalance(userAccountDetails.getBalance());
		response.setTransactionAmount(transactionAmount);

		return response;

	}
}
