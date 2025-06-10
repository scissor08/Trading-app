package com.tradingapplication.TradingApplication.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.razorpay.Order;
import com.tradingapplication.TradingApplication.DateTime.WalletDTO;
import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Entity.Wallet;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.WalletReportRep;
import com.tradingapplication.TradingApplication.Security.AuthUtil;
import com.tradingapplication.TradingApplication.Service.PaymentService;
import com.tradingapplication.TradingApplication.Service.UserDashboardService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class PaymentController {

    @Autowired
    private PaymentService paymentService;
    
    @Autowired
    UserDashboardService userDashboardService;
    @Autowired
    private WalletReportRep transactionRepository;
    @Autowired
    UserDetailsRepository userRepo;
    @Autowired
   AuthUtil authUtil;

    @GetMapping("/pay")
    public String showPaymentPage(Model model) {
        model.addAttribute("razorpayKey", paymentService.getRazorpayKey());
        return "payment";
    }

    @PostMapping("/payment/create-order")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createOrder(Model model,@RequestParam int amount) {
        try {
            Order order = paymentService.createOrder(amount);
            Map<String, Object> response = new HashMap<>();
            response.put("id", order.get("id"));
            response.put("amount", order.get("amount"));
            response.put("currency", order.get("currency"));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("error", e.getMessage());
            return ResponseEntity.status(500).body(error);
        }
    }
    
   
    
    @GetMapping("/wallets")
    public String showWalletPage(Model model) {
        try {
            String currentUser = authUtil.getCurrentUsername();
            UserTable userTable = userRepo.findByUsername(currentUser)
                .orElseThrow(() -> new DataNotFoundException("User Not Found"));
            
            // Get user balance
            UserAccountDetails account = userTable.getUserAccountDetails();
            model.addAttribute("balance", account.getBalance());
            model.addAttribute("user", userTable);
            model.addAttribute("username", currentUser);
            
            // Get user transactions
            List<Wallet> transactions = transactionRepository.findByUsernameOrderByTimestampDesc(currentUser);
          
            List<WalletDTO> transactions1 =transactions
                    .stream()
                    .map(WalletDTO::new)
                    .collect(Collectors.toList());
            model.addAttribute("transactions", transactions1);
            
            return "WalletPage"; // Return JSP page
        } catch (Exception e) {
            log.error("Error loading wallet page: ", e);
            return "error"; // Return error page
        }
    }

    // 2. Keep payment success as API endpoint but don't handle page display
    @PostMapping("/payment-success")
    public ResponseEntity<String> handlePaymentSuccess(@RequestBody Map<String, Object> payload) {
        try {
            String getUser = authUtil.getCurrentUsername();
            UserTable userTable = userRepo.findByUsername(getUser)
                .orElseThrow(() -> new DataNotFoundException("User Not Found"));
            
            double amount = (((Number) payload.get("amount")).doubleValue()) / 100;
            String username = (String) payload.get("username");
            String razorpayPaymentId = (String) payload.get("razorpay_payment_id");
            String razorpayOrderId = (String) payload.get("razorpay_order_id");
            String razorpaySignature = (String) payload.get("razorpay_signature");
            
            // Just update the wallet, don't handle page display
            userDashboardService.updateWalletBalance(userTable, amount, username, 
                razorpayPaymentId, razorpayOrderId, razorpaySignature);
            
            return ResponseEntity.ok("Wallet updated successfully");
        } catch (Exception e) {
            log.error("Payment success handling failed: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Failed to update wallet");
        }
    }
}
