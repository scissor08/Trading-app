package com.tradingapplication.TradingApplication.Entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Wallet {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;

    private String type; // "ADD" or "WITHDRAW"

    private Double amount;
    @Column(name = "timestamp") // database column name
    private LocalDateTime timestamp;
  

    private String status; // "SUCCESS", "FAILED", etc.
     
    
    @OneToOne
    @JoinColumn(name = "user_id")
    private UserTable user;

  
}
