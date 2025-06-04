// Updated WalletReportService.java
package com.tradingapplication.TradingApplication.Service;

import java.time.LocalDateTime;
import java.util.List;

import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.tradingapplication.TradingApplication.Entity.WalletReport;

import com.tradingapplication.TradingApplication.Repository.WalletReportRep;

import com.tradingapplication.TradingApplication.dto.WalResponseDTO;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class WalletReportService implements WalletReportInterface {


    @Autowired
    private WalletReportRep transactionRepository;

    @Override
    public void addMoney(double amount) {
    	
        WalletReport tx = new WalletReport();
        tx.setAmount(amount);
        tx.setType("ADD");
        tx.setStatus("SUCCESS");
        tx.setTimestamp(LocalDateTime.now());
        transactionRepository.save(tx);
    }

    @Override
    public void withdrawMoney(double amount) {
        WalletReport tx = new WalletReport();
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
    public List<WalResponseDTO> getAllTransactions() {
    	
        return transactionRepository.findAllByOrderByTimestampDesc()
                .stream()
                .map(tx -> {
                    WalResponseDTO dto = new WalResponseDTO();
                    dto.setAmount(tx.getAmount());
                    dto.setType(tx.getType());
                    dto.setStatus(tx.getStatus());
                    log.info(""+tx.getAmount());
                    return dto;
                }).collect(Collectors.toList());
    }
}
