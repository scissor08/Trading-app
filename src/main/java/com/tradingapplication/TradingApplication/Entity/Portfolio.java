package com.tradingapplication.TradingApplication.Entity;

<<<<<<< HEAD
import java.util.Date; 
=======
import java.time.LocalDateTime;
import java.util.Date;
>>>>>>> a3ac05be4e3b6af2f2828c87a450a1013318ae8a

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
<<<<<<< HEAD
=======
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
>>>>>>> a3ac05be4e3b6af2f2828c87a450a1013318ae8a
import jakarta.persistence.OneToOne;
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
<<<<<<< HEAD
	private Date transactionTime;
	private int quantity;
	private double price;
=======
	private LocalDateTime transactionTime;
	private int quantity;
	
	private double price;
	  private String symbol;
>>>>>>> a3ac05be4e3b6af2f2828c87a450a1013318ae8a
	
	@ManyToOne(fetch = FetchType.LAZY)
	User user;
	
	@ManyToOne(fetch = FetchType.LAZY)
	Stocks stocks;
	
	private String transactionType;
	
}
