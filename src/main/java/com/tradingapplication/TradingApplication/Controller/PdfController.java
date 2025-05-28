package com.tradingapplication.TradingApplication.Controller;

import com.tradingapplication.TradingApplication.Service.PdfService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.ByteArrayInputStream;

@RestController
@RequestMapping("/pdf")
public class PdfController {

    @Autowired
    private PdfService pdfService;

    @GetMapping("/download")
    public ResponseEntity<byte[]> downloadPdf(HttpSession session) {
        ByteArrayInputStream bis = pdfService.generatePdf(session);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "inline; filename=transactions.pdf");

        return ResponseEntity
                .ok()
                .headers(headers)
                .contentType(MediaType.APPLICATION_PDF)
                .body(bis.readAllBytes());
    }
}
