package com.tradingapplication.TradingApplication.Entity;



import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Portfolio {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int orderId;
	@Temporal(TemporalType.DATE)
	private Date transactionTime;

	@ManyToOne(fetch = FetchType.LAZY)
	User user;
	
	@ManyToOne(fetch = FetchType.LAZY)
	Stock stocks;
	
	private String transactionType;
	
}
