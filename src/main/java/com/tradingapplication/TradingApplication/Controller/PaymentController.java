package com.tradingapplication.TradingApplication.Controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.razorpay.Order;
import com.tradingapplication.TradingApplication.Service.PaymentService;

@Controller
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @GetMapping("/pay")
    public String showPaymentPage(Model model) {
        model.addAttribute("razorpayKey", paymentService.getRazorpayKey());
        return "payment";
    }

    @PostMapping("/payment/create-order")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createOrder(@RequestParam int amount) {
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
}
