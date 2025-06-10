package com.tradingapplication.TradingApplication.Entity;

import jakarta.persistence.*; 
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "watchlist")
public class Watchlist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String symbol;
    
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserTable user;
  
    @ManyToOne
    @JoinColumn(name = "stock_id")
    private Stock stock;
    
}

