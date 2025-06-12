//// Updated WalletReportService.java
//package com.tradingapplication.TradingApplication.Service;
//
//import java.time.LocalDateTime;
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.tradingapplication.TradingApplication.Entity.UserTable;
//import com.tradingapplication.TradingApplication.Entity.Wallet;
//import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
//import com.tradingapplication.TradingApplication.Repository.WalletReportRep;
//import com.tradingapplication.TradingApplication.Security.AuthUtil;
//import com.tradingapplication.TradingApplication.globalException.DataNotFoundException;
//
//import lombok.extern.slf4j.Slf4j;
//
//@Service
//@Slf4j
//public class WalletReportService implements WalletReportInterface {
//
//
//    @Autowired
//    private WalletReportRep transactionRepository;
//    @Autowired
//    UserDetailsRepository userRepo;
//  
//    	
//    	@Override
//    	public void addMoney(double amount, String username,String razorpayPaymentId,String razorpayOrderId,String razorpaySignature) {
//    	    UserTable user=userRepo.findByUsername(username).orElseThrow(()->new DataNotFoundException("user not exists"));
//    		Wallet tx = new Wallet();
//    	    tx.setAmount(amount / 100); // convert paise to INR
//    	    tx.setType("ADD");
//    	    tx.setStatus("SUCCESS");
//    	    tx.setUsername(username);
//    	    tx.setTimestamp(LocalDateTime.now());
//    	    tx.setRazorpayOrderId(razorpayOrderId);
//    	    tx.setRazorpayPaymentId(razorpayPaymentId);
//    	    tx.setRazorpaySignature(razorpaySignature);
//    	    tx.setUser(user);
//
//    	    transactionRepository.save(tx);
//    	}
//
//    
//
//    @Override
//    public void withdrawMoney(double amount) {
//        Wallet tx = new Wallet();
//        tx.setAmount(amount);
//        tx.setType("WITHDRAW");
//        if (amount > 0) {
//            tx.setStatus("SUCCESS");
//        } else {
//            tx.setStatus("FAILED");
//        }
//        tx.setTimestamp(LocalDateTime.now());
//        transactionRepository.save(tx);
//    }
//
//    @Override
//    public  List<Wallet> getAllTransactions() {
// 	   System.out.println("varava" );
//
//    	   return transactionRepository.findAll();
//    	  
//    }
//}
