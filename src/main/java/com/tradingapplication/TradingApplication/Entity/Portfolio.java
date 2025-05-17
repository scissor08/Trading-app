package com.tradingapplication.TradingApplication.Entity;

<<<<<<< HEAD

import java.util.Date;
=======
import java.util.Date; 
>>>>>>> 8c7e053acf4a808e72c7cde4d2079dcdf265dd9b

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
	private int quantity;
<<<<<<< HEAD

=======
	private double price; 
	
>>>>>>> 8c7e053acf4a808e72c7cde4d2079dcdf265dd9b
	@ManyToOne(fetch = FetchType.LAZY)
	User user;
	
	@ManyToOne(fetch = FetchType.LAZY)
	StockDetails stocks;
	
	private String transactionType;
	
}
