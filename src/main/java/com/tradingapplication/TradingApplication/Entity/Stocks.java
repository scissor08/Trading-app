package com.tradingapplication.TradingApplication.Entity;

<<<<<<< HEAD
import jakarta.persistence.Entity; 
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
=======


import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
>>>>>>> a3ac05be4e3b6af2f2828c87a450a1013318ae8a
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Stocks {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int stockId;
	private String stockName;
	
	@OneToOne(mappedBy="stocks")
	StockDetails stockdetails;
	

    @OneToMany(mappedBy = "stocks", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Portfolio> portfolioRecords;
	
}
