package com.tradingapplication.TradingApplication.Entity;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
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
public class StockDetails {

	@Id
	private String symbol;
    private double price;
    private Integer quantity;
    
    @OneToOne
    Stocks stocks;

    @OneToMany(mappedBy = "stocks", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Portfolio> portfolioRecords;
    
    
}
