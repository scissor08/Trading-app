package com.tradingapplication.TradingApplication.Controller;

import java.util.HashMap;
import java.util.Map;

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
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Security.AuthUtil;
import com.tradingapplication.TradingApplication.Service.PaymentService;
import com.tradingapplication.TradingApplication.Service.UserDashboardService;

@Controller
public class PaymentController {

    @Autowired
    private PaymentService paymentService;
    
    @Autowired
    UserDashboardService userDashboardService;
    
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
    
   
    
    
    @PostMapping("/payment-success")
    public ResponseEntity<String> handlePaymentSuccess(Model model,@RequestBody Map<String, Object> payload) {
        try {
        	 String getUser = authUtil.getCurrentUsername();
        	 UserTable userTable=userRepo.findByUsername(getUser).orElseThrow(()-> new DataNotFoundException("User Not Found"));
            double amount = (((Number) payload.get("amount")).doubleValue())/100;
            String username = (String) payload.get("username");
           String razorpayPaymentId=(String) payload.get("razorpay_payment_id");
         String razorpayOrderId=(String) payload.get("razorpay_order_id");
            String razorpaySignature=(String) payload.get("razorpay_signature");
            
           
            

            userDashboardService.addAccountBalance(userTable,amount, username,razorpayPaymentId,razorpayOrderId,razorpaySignature,model);

            return ResponseEntity.ok("Wallet updated");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update wallet");
        }
    }

}
