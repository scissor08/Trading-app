package com.tradingapplication.TradingApplication.Entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne; // ✅ Use ManyToOne if one user has many transactions
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Wallet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String username;

    private String type; // "ADD" or "WITHDRAW"

    private Double amount;

    @Column(name = "timestamp")
    private LocalDateTime timestamp;

    private String status; // "SUCCESS", "FAILED", etc.

    // ✅ Razorpay Payment IDs (optional but useful for audit/logs)
    private String razorpayPaymentId;
    private String razorpayOrderId;
    private String razorpaySignature;

    
  
    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserTable user;



	@Override
	public String toString() {
		return "Wallet [id=" + id + ", username=" + username + ", type=" + type + ", amount=" + amount + ", timestamp="
				+ timestamp + ", status=" + status + ", razorpayPaymentId=" + razorpayPaymentId + ", razorpayOrderId="
				+ razorpayOrderId + ", razorpaySignature=" + razorpaySignature + ", user=" + user + "]";
	}

    // ✅ Each user can have multiple wallet transactions
}
