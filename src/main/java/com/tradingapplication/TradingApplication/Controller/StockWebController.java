package com.tradingapplication.TradingApplication.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tradingapplication.TradingApplication.Service.StockServiceInterface;
import com.tradingapplication.TradingApplication.Service.UserDashboardServiceInterface;
import com.tradingapplication.TradingApplication.dto.StockRequestDTO;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class StockWebController {
	
    private final StockServiceInterface stockService;
    @Autowired
    private final  UserDashboardServiceInterface userDashboardServiceInterface;

    @GetMapping("/viewstock")
    public String viewStockForm() {
        return "stock"; // stock.jsp
    }

//    @PostMapping("/getStock")
//    public String getStock(@RequestParam("symbol") String symbol, Model model) {
//        try {
//            StockRequestDTO stock = stockService.fetchStock(symbol.toUpperCase());
//            model.addAttribute("stock", stock);
//            return "stockDetails"; // result.jsp
//        } catch (Exception e) {
//            model.addAttribute("error", "Failed to fetch stock: " + e.getMessage());
//            return "stock";
//        }
//    }
    
    @GetMapping("/stock/search")
    public String redirectToStock(
            @RequestParam("symbol") String symbol,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        try {
            StockRequestDTO stock = stockService.fetchStock(symbol.toUpperCase());

            if (stock == null || stock.getSymbol() == null) {
                throw new RuntimeException("No data");
            }

            return "redirect:/stock/" + symbol.toUpperCase();

        } catch (Exception e) {
            String referer = request.getHeader("Referer"); // get the previous page
            redirectAttributes.addFlashAttribute("error", "No data found for symbol: " + symbol.toUpperCase());
            return "redirect:" + (referer != null ? referer : "/");
        }
    }

    
    
    @GetMapping("/stock/{symbol}")
    public String getStockDetails(@PathVariable String symbol, Model model,HttpSession session) {
        try {
        	
            StockRequestDTO stock = stockService.fetchStock(symbol.toUpperCase());
            
           Double mainBalance=getAccountBalance(session);
            model.addAttribute("stock", stock);
            model.addAttribute("balance",mainBalance );
            return "stockDetails";  // stockDetails.jsp
        } catch (Exception e) {
            model.addAttribute("error", "Stock not found: " + symbol);
            return "error";  // Optional error.jsp
        }
    }
    @GetMapping("/getAccountBalance")
    public Double getAccountBalance(HttpSession session) {
       
            double balance = userDashboardServiceInterface.getMainBalance(session);
        return balance;
    }

    @GetMapping("/stocks")
    public String getAllStocks(Model model) {
      //  List<String> symbols = List.of("AAPL", "GOOGL", "MSFT", "AMZN", "TSLA", "META", "NFLX", "NVDA", "ADBE", "INTC");
        List<StockRequestDTO> stocks = stockService.findAllStocks();
        model.addAttribute("stocks", stocks);
        return "allStocks"; // allStocks.jsp
    }

    @PostConstruct
    public void preloadStocks() {
        List<String> symbols = List.of("AAPL", "GOOGL", "MSFT", "AMZN", "TSLA", "META", "NFLX", "NVDA", "ADBE", "INTC");
        stockService.fetchMultipleStocks(symbols);
    }
}
