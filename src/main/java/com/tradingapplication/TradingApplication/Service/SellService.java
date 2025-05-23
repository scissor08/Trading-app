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
import com.tradingapplication.TradingApplication.dto.SellRequestDTO;
import com.tradingapplication.TradingApplication.dto.SellResponseDTO;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class SellService implements SellServiceInterface {

    private static final String TRANSACTION_TYPE_SELL = "Sell";
    private static final String TRANSACTION_STATUS_SUCCESS = "success";
    private static final String TRANSACTION_SUCCESS_MESSAGE = "Sell transaction successful.";

    @Autowired
    private PortfolioRepository portfolioRepository;

    @Autowired
    private StockRepository stockRepository;

    @Autowired
    private UserAccountDetailsRepository userAccountDetailsRepository;

    @Autowired
    private TranscationRepository transcationRepository;

    @Override
    public SellResponseDTO sellStock(int id, SellRequestDTO request) {

        log.info("SellStock Method Invoked for userId: {}, symbol: {}, quantity: {}",
                id, request.getSymbol(), request.getQuantity());

        validateSellRequest(request);

        UserAccountDetails user = userAccountDetailsRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("User not found"));

        Stock stock = getStockOrThrow(request.getSymbol());
        int quantityToSell = request.getQuantity();
        double stockPrice = Double.parseDouble(stock.getPrice());
        double transactionAmount = stockPrice * quantityToSell;

        Portfolio portfolio = portfolioRepository
                .findByUserAndStocks(user.getUserdetails(), stock)
                .orElseThrow(() -> new DataNotFoundException("Stock not found in user's portfolio"));

        if (portfolio.getQuantity() < quantityToSell) {
            throw new IllegalArgumentException("Not enough stocks to sell.");
        }

        portfolio.setQuantity(portfolio.getQuantity() - quantityToSell);
        portfolio.setTrancationAmount(portfolio.getTrancationAmount() - transactionAmount);
        if (portfolio.getQuantity() == 0) {
            portfolioRepository.delete(portfolio);
        } else {
            portfolioRepository.save(portfolio);
        }

        double updatedBalance = user.getBalance() + transactionAmount;
        user.setBalance(updatedBalance);
        userAccountDetailsRepository.save(user);

        TransactionBuySell transaction = new TransactionBuySell();
        transaction.setOrderId(UUID.randomUUID().toString());
        transaction.setTransactionTime(new Date());
        transaction.setStockName(stock.getSymbol());
        transaction.setNoOfStocks(quantityToSell);
        transaction.setCurrentPrice(stockPrice);
        transaction.setTotalAmount(transactionAmount);
        transaction.setUserDetails(user.getUserdetails());
        transaction.setTransactionType(TRANSACTION_TYPE_SELL);
        transcationRepository.save(transaction);

        SellResponseDTO response = new SellResponseDTO();
        response.setStatus(TRANSACTION_STATUS_SUCCESS);
        response.setMessage(TRANSACTION_SUCCESS_MESSAGE);
        response.setRemainingBalance(updatedBalance);
        response.setTransactionAmount(transactionAmount);
        response.setStockSymbol(stock.getSymbol());
        response.setQuantity(quantityToSell);

        return response;
    }

    private void validateSellRequest(SellRequestDTO request) {
        if (request == null || request.getSymbol() == null || request.getQuantity() == null || request.getQuantity() <= 0) {
            throw new IllegalArgumentException("Invalid sell request");
        }
    }

    private Stock getStockOrThrow(String symbol) {
        return stockRepository.findBySymbol(symbol)
                .orElseThrow(() -> new DataNotFoundException("Stock not found with symbol: " + symbol));
    }
}

