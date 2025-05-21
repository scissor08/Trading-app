
package com.tradingapplication.TradingApplication.Service;


import java.util.Date;  
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.Stock;
import com.tradingapplication.TradingApplication.Entity.TransactionBuySell;
import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.PortfolioRepository;
import com.tradingapplication.TradingApplication.Repository.StockRepository;
import com.tradingapplication.TradingApplication.Repository.UserAccountDetailsRepository;
import com.tradingapplication.TradingApplication.dto.BuyRequestDTO;
import com.tradingapplication.TradingApplication.dto.BuyResponseDTO;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BuyService implements BuyServiceInterface {
	
	 
    private static final String TRANSACTION_TYPE_BUY = "Buy";
    private static final String TRANSACTION_STATUS_SUCCESS = "success";
    private static final String TRANSACTION_SUCCESS_MESSAGE = "Buy transaction successful.";

    @Autowired
    private PortfolioRepository portfolioRepository;

    @Autowired
    private StockRepository stockRepository;

    @Autowired
    private UserAccountDetailsRepository userAccountDetailsRepository;
    @Autowired
    TranscationRepository transcationRepository;

    public BuyResponseDTO buyStock(int id, BuyRequestDTO request) {
    	
    	log.info("BuyStock Method Invoked for userId: {}, symbol: {}, quantity: {}",
    	         id, request.getSymbol(), request.getQuantity());


        validateBuyRequest(request);

        UserAccountDetails user = userAccountDetailsRepository.findById(id)
            .orElseThrow(() -> new DataNotFoundException("User not found"));

        Stock stock = getStockOrThrow(request.getSymbol());
        int quantity = request.getQuantity();
        double stockPrice = Double.parseDouble(stock.getPrice());
        double transactionAmount = stockPrice * quantity;

        if (transactionAmount > user.getBalance()) {
        	 log.warn("Insufficient balance for userId {}: balance={}, required={}", 
                     user.getUserdetails().getUserId(), user.getBalance(), transactionAmount);
            throw new IllegalArgumentException("Low Wallet Balance! Please add funds.");
        }

//        String orderId = UUID.randomUUID().toString();
//        String transactionTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

        double updatedBalance = user.getBalance() - transactionAmount;
        log.info("User {} wallet updated. New balance: {}", user.getUserdetails().getUserId(), updatedBalance);
        user.setBalance(updatedBalance);
        userAccountDetailsRepository.save(user);
        
        
        Portfolio portfolio = portfolioRepository
                .findByUserAndStocks(user.getUserdetails(), stock)
                .orElse(null);

            if (portfolio != null) {
                portfolio.setQuantity(portfolio.getQuantity() + quantity);
                portfolio.setTrancationAmount(portfolio.getTrancationAmount() + transactionAmount);
                log.info("Portfolio Updated");
            } else {
                portfolio = new Portfolio();
                portfolio.setQuantity(quantity);
                portfolio.setTrancationAmount(transactionAmount);
                portfolio.setUser(user.getUserdetails());
                portfolio.setPrice(request.getCurrentPrice());
                portfolio.setSymbol(request.getSymbol());
                portfolio.setStocks(stock);
            }
            portfolioRepository.save(portfolio);
            
            log.info("new Portfolio Created");
            
        
        TransactionBuySell transaction = new TransactionBuySell();
        transaction.setOrderId(UUID.randomUUID().toString());
        transaction.setTransactionTime(new Date());
        transaction.setStockName(stock.getSymbol());
        transaction.setNoOfStocks(quantity);
        transaction.setCurrentPrice(stockPrice);
        transaction.setTotalAmount(transactionAmount);
        transaction.setUserDetails(user.getUserdetails());
        transaction.setTransactionType(TRANSACTION_TYPE_BUY);
        transcationRepository.save(transaction);
        log.info("Transaction completed. Order ID: {}, Amount: {}", transaction.getOrderId(), transactionAmount);


        BuyResponseDTO response = new BuyResponseDTO();
        response.setStatus(TRANSACTION_STATUS_SUCCESS);
        response.setMessage(TRANSACTION_SUCCESS_MESSAGE);
        response.setRemainingBalance(updatedBalance);
        response.setTransactionAmount(transactionAmount);
        response.setStockSymbol(stock.getSymbol());
        response.setQuantity(quantity);
        
        log.info("response Generated");

        return response;
        
    }

    private void validateBuyRequest(BuyRequestDTO request) {
        if (request == null) {
        	log.error("Buy request is null");
            throw new IllegalArgumentException("Request body is missing");
        }
        if (request.getSymbol() == null || request.getSymbol().isEmpty()) {
            throw new IllegalArgumentException("Stock symbol is required");
        }
        if (request.getQuantity() == null || request.getQuantity() <= 0) {
            throw new IllegalArgumentException("Quantity must be greater than zero");
        }
        log.info("validation sucessfull");
    }

    private Stock getStockOrThrow(String symbol) {
        return stockRepository.findBySymbol(symbol)
                .orElseThrow(() -> new DataNotFoundException("Stock not found with symbol: " + symbol));
    }

}
