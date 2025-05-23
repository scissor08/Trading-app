package com.tradingapplication.TradingApplication.Entity;



import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
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
	private Integer id;
	
	String username;
	
	
	private Integer quantity;
	private String symbol;	
	private Double price;
	private Double trancationAmount;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id") // Optional: matches `UserDetails.userId`
	private UserDetails user;

	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="stock_id")
	Stock stocks;
	
	
	
}
