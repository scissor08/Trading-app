package com.tradingapplication.TradingApplication.Entity;



import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
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
