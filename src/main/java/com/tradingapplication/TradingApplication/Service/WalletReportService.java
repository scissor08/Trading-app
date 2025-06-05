// Updated WalletReportService.java
package com.tradingapplication.TradingApplication.Service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.Wallet;
import com.tradingapplication.TradingApplication.Repository.WalletReportRep;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class WalletReportService implements WalletReportInterface {


    @Autowired
    private WalletReportRep transactionRepository;

    @Override
    public void addMoney(double amount) {
    	
        Wallet tx = new Wallet();
        tx.setAmount(amount);
        tx.setType("ADD");
        tx.setStatus("SUCCESS");
        tx.setTimestamp(LocalDateTime.now());
        transactionRepository.save(tx);
    }

    @Override
    public void withdrawMoney(double amount) {
        Wallet tx = new Wallet();
        tx.setAmount(amount);
        tx.setType("WITHDRAW");
        if (amount > 0) {
            tx.setStatus("SUCCESS");
        } else {
            tx.setStatus("FAILED");
        }
        tx.setTimestamp(LocalDateTime.now());
        transactionRepository.save(tx);
    }

    @Override
    public  List<Wallet> getAllTransactions() {
 	   System.out.println("varava" );

    	   return transactionRepository.findAll();
    	  
    }
}
