package com.tradingapplication.TradingApplication.Controller;


import com.tradingapplication.TradingApplication.Entity.Wallet;
import com.tradingapplication.TradingApplication.Repository.WalletReportRep;
import com.tradingapplication.TradingApplication.Service.PdfService;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayInputStream;
import java.util.List;

@RestController
@RequestMapping("/api/wallet")
public class WalletPdfController {

    @Autowired
    private WalletReportRep walletReportRep;
    @Autowired
    PdfService pdfService;

    @GetMapping("/pdf")
    public ResponseEntity<InputStreamResource> downloadWalletPdf() {
        List<Wallet> walletList =walletReportRep.findAll();

        ByteArrayInputStream bis = pdfService.walletPdfReport(walletList);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=wallet_history.pdf");

        return ResponseEntity
                .ok()
                .headers(headers)
                .contentType(MediaType.APPLICATION_PDF)
                .body(new InputStreamResource(bis));
    }
}
