package com.tradingapplication.TradingApplication.Service;

import java.util.ArrayList;  
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.Entity.GrowthReportEntity;
import com.tradingapplication.TradingApplication.Entity.Stock;
import com.tradingapplication.TradingApplication.Entity.TransactionBuySell;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.TransactionRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;

@Service
public class GrowthReportService implements GrowthReportServiceInterface {

	@Autowired
	UserDetailsRepository userRepository;
	@Autowired
	TransactionRepository transactionRepository;
	
	@Override
	public List<GrowthReportEntity> getGrowthReport(String username,Model model) {
	
		UserDetails user = userRepository.findByUsername(username).orElseThrow(()->new DataNotFoundException("LoginPage"));
		
		List<Stock> stocks=user.getStocks();
		List<TransactionBuySell> transaction=user.getTransaction();	
		List<String> stockSymbols=Arrays.asList("AAPL", "GOOGL", "MSFT", "AMZN", "TSLA", "META", "NFLX", "NVDA", "ADBE", "INTC");	
		List<GrowthReportEntity> growthReport = new ArrayList<>();
		
		
		for (String stockname : stockSymbols) {
			double totalbuystock=0;
			double totalbuyvalue=0;
			double totalsellstock=0;
			double totalsellvalue=0;
			double averagebuyvalue=0;
			double averagesellvalue=0;
			double profitvalue=0;
			double stockholdings=0;
			String symbol=null;
			double currentprofit=0;
			double currentprice=0;
			for (TransactionBuySell trans : transaction) {
				if(trans.getStockName().equals(stockname)&&trans.getTransactionType().equals("Buy")) {
					 totalbuystock+=trans.getNoOfStocks();
					 totalbuyvalue+=trans.getTotalAmount();
					 averagebuyvalue=totalbuyvalue/totalbuystock;
				}
				if(trans.getStockName().equals(stockname)&&trans.getTransactionType().equals("Sell")) {
					totalsellstock+=trans.getNoOfStocks();
					totalsellvalue+=trans.getTotalAmount();
					averagesellvalue=totalsellvalue/totalsellstock;
				}	
			}
			for(Stock curstock : stocks) {
				if(curstock.getSymbol().equals(stockname)) {
					currentprice=Double.valueOf(curstock.getPrice());
				}
			}
			symbol=stockname;
			stockholdings=totalbuystock-totalsellstock;
			profitvalue=averagebuyvalue-(stockholdings*averagebuyvalue)-averagesellvalue;
			currentprofit=(averagebuyvalue*stockholdings)-(currentprice*stockholdings);
			
			GrowthReportEntity growthRe=new GrowthReportEntity();
			growthRe.setStockSymbol(symbol);
			growthRe.setTotalBuyPrice(totalbuyvalue);
			growthRe.setTotalBuyQuantity(totalbuystock);
			growthRe.setTotalSellPrice(totalsellvalue);
			growthRe.setTotalSellQuantity(totalsellstock);
			growthRe.setAverageBuyValue(averagebuyvalue);
			growthRe.setAverageSellValue(averagesellvalue);
			growthRe.setProfitValue(profitvalue);
			growthRe.setCurrentHoldings(stockholdings);
			growthRe.setCurrentProfitValue(currentprofit);
			if (growthRe.getTotalBuyPrice()>0.0) {
			growthReport.add(growthRe);
			}
		}
		
		return growthReport;
	}
	
	
}
