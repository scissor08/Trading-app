package com.tradingapplication.TradingApplication.Entity;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TransactionBuySell {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String orderId;
	private Date transactionTime;
	private String StockName;
	private int noOfStocks;
	private double currentPrice;
	private double totalAmount;
	private String transactionType; // "BUY" or "SELL"

	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private UserDetails userDetails;


}
