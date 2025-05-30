package com.tradingapplication.TradingApplication.Service;
 
import java.io.PrintWriter; 
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.Entity.GrowthReportEntity;
import com.tradingapplication.TradingApplication.Entity.Stock;
import com.tradingapplication.TradingApplication.Entity.TransactionBuySell;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.GrowthReportRepository;
import com.tradingapplication.TradingApplication.Repository.StockRepository;
import com.tradingapplication.TradingApplication.Repository.TransactionRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;

@Service
public class GrowthReportService implements GrowthReportServiceInterface {

	@Autowired
	UserDetailsRepository userRepository;
	@Autowired
	TransactionRepository transactionRepository;
	@Autowired
	GrowthReportRepository growthRepo;
	@Autowired
	StockRepository stockRepo;
	
	
	@Override
	public List<GrowthReportEntity> getGrowthReport(String username, Model model) {

		UserDetails user = userRepository.findByUsername(username)
				.orElseThrow(() -> new DataNotFoundException("LoginPage"));

		List<Stock> stocks = stockRepo.findAll();
		List<TransactionBuySell> transaction = user.getTransaction();
		List<String> stockSymbols=new ArrayList<String>();
		for(Stock symbol : stocks) {
		 stockSymbols.add(symbol.getSymbol());
		}
		System.out.println(stockSymbols);
		List<GrowthReportEntity> growthReport = new ArrayList<>();

		for (String stockname : stockSymbols) {
			double totalbuystock = 0;
			double totalbuyvalue = 0;
			double totalsellstock = 0;
			double totalsellvalue = 0;
			double averagebuyvalue = 0;
			double averagesellvalue = 0;
			double profitvalue = 0;
			double stockholdings = 0;
			String symbol = null;
			double currentprofit = 0;
			double currentprice = 0;
			double totalprofitpercentage=0;
			double currentprofitpercentage=0;
			for (TransactionBuySell trans : transaction) {
				if (trans.getStockName().equals(stockname) && trans.getTransactionType().equalsIgnoreCase("Buy")
						&& trans.getUserDetails().getUserId() == user.getUserId()) {
					totalbuystock += trans.getNoOfStocks();
					totalbuyvalue += trans.getTotalAmount();
					averagebuyvalue = totalbuyvalue / totalbuystock;
				}
				if (trans.getStockName().equals(stockname) && trans.getTransactionType().equalsIgnoreCase("Sell")
						&& trans.getUserDetails().getUserId() == user.getUserId()) {
					totalsellstock += trans.getNoOfStocks();
					totalsellvalue += trans.getTotalAmount();
					averagesellvalue = totalsellvalue / totalsellstock;
				}
			}
			for (Stock curstock : stocks) {
				if (curstock.getSymbol().equals(stockname)) {
					currentprice = Double.valueOf(curstock.getPrice());
				}
			}
			symbol = stockname;
			stockholdings = totalbuystock - totalsellstock;
			profitvalue = (totalsellstock * averagesellvalue)-((totalbuystock - stockholdings) * averagebuyvalue);
			totalprofitpercentage=(totalsellstock * averagesellvalue)/((totalbuystock - stockholdings) * averagebuyvalue)*100;
			currentprofit = (currentprice * stockholdings)-(averagebuyvalue * stockholdings);
			currentprofitpercentage=((currentprice*stockholdings)/(averagebuyvalue*stockholdings))*100;
			
			GrowthReportEntity growthRe = new GrowthReportEntity();
			growthRe.setStockSymbol(symbol);
			growthRe.setTotalBuyPrice(changeValue(totalbuyvalue));
			growthRe.setTotalBuyQuantity(totalbuystock);
			growthRe.setTotalSellPrice(changeValue(totalsellvalue));
			growthRe.setTotalSellQuantity(totalsellstock);
			growthRe.setAverageBuyValue(changeValue(averagebuyvalue));
			growthRe.setAverageSellValue(changeValue(averagesellvalue));
			growthRe.setProfitValue(changeValue(profitvalue));
			growthRe.setCurrentHoldings(stockholdings);
			growthRe.setCurrentProfitValue(changeValue(currentprofit));
			growthRe.setTotalProfitPercentage(totalprofitpercentage);
			growthRe.setCurrentProfitPercentage(currentprofitpercentage);
			if (growthRe.getTotalBuyPrice() > 0.0) {
				growthReport.add(growthRe);
				growthRepo.save(growthRe);
				
			}
		}
		return growthReport;
	}

	public double changeValue(double value) {
		return Double.parseDouble(String.format("%.3f", value));
	}
	
	@Override
	public void exportCsv(PrintWriter writer) {
	    List<GrowthReportEntity> reports = growthRepo.findAll(); // or however you fetch

	    writer.println("Stock Symbol,Total Buy Qty,Total Buy Price,Total Sell Qty,Total Sell Price,Avg Buy,Avg Sell,Holdings,Profit,Current Profit");
	    for (GrowthReportEntity r : reports) {
	    	 writer.printf("%s,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f%n",
	            r.getStockSymbol(), r.getTotalBuyQuantity(), r.getTotalBuyPrice(),
	            r.getTotalSellQuantity(), r.getTotalSellPrice(), r.getAverageBuyValue(),
	            r.getAverageSellValue(), r.getCurrentHoldings(),
	            r.getProfitValue(), r.getCurrentProfitValue());
	    }
	}

}
