package com.tradingapplication.TradingApplication.Controller;



import com.tradingapplication.TradingApplication.Entity.Portfolio;

import com.tradingapplication.TradingApplication.Repository.PortfolioRepository;


import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.IOException;
import java.util.List;

@Controller
public class HoldingsController {

    @Autowired
    private com.tradingapplication.TradingApplication.Service.HoldingsPdfService pdfService;

    @Autowired
    private PortfolioRepository holdingsRepository;

    @GetMapping("/downloadHoldingsPdf")
    public void downloadHoldingsReport(HttpServletResponse response) throws IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=HoldingsReport.pdf");

        List<Portfolio> holdings = holdingsRepository.findAll(); // Get real data
        pdfService.generateHoldingsPDF(holdings, response);
    }
}

