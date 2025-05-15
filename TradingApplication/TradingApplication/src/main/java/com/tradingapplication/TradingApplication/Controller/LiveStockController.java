package com.tradingapplication.TradingApplication.Controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tradingapplication.TradingApplication.Service.LiveStockService;

@Controller
@RequestMapping("/live")
public class LiveStockController {

    @Autowired
    private LiveStockService liveStockService;

    @GetMapping("/view")
    public String viewLiveStock(@RequestParam String symbol, Model model) {
        Map<String, String> stockData = liveStockService.getStockQuote(symbol);
        model.addAttribute("stock", stockData);
        return "liveStock"; // maps to /WEB-INF/views/liveStock.jsp
    }
}
