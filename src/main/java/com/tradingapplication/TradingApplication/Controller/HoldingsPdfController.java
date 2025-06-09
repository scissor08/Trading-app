package com.tradingapplication.TradingApplication.Controller;

import com.tradingapplication.TradingApplication.Service.HoldingsPdfService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.ByteArrayInputStream;

@Controller
@RequestMapping("/holdings/pdf")
public class HoldingsPdfController {

    @Autowired
    private HoldingsPdfService holdingsPdfService;

    @GetMapping("/download")
    public ResponseEntity<byte[]> downloadHoldingsPdf(HttpSession session) {
        ByteArrayInputStream bis = holdingsPdfService.generateHoldingsReport(session);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=HoldingsReport.pdf");

        return ResponseEntity
                .ok()
                .headers(headers)
                .contentType(MediaType.APPLICATION_PDF)
                .body(bis.readAllBytes());
    }

    @GetMapping("/report")
    public String showReportPage() {
        return "reportPdf"; // Your JSP view to show the download button
    }
}
