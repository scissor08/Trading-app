package com.tradingapplication.TradingApplication.Entity;

import jakarta.persistence.Entity;
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
public class GrowthReportEntity {
	
	@Id
	String stockSymbol;
	double totalBuyQuantity;
	double totalBuyPrice;
	double totalSellQuantity;
	double totalSellPrice;
	double averageBuyValue;
	double averageSellValue;
	double profitValue;
	double totalProfitPercentage;
	double currentHoldings;
	double currentProfitValue;
	double currentProfitPercentage;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	UserTable userTable;
}
