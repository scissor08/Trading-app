package com.tradingapplication.TradingApplication.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
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
	double currentHoldings;
	double currentProfitValue;
	
}
