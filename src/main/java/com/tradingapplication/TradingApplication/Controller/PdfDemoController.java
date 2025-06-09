package com.tradingapplication.TradingApplication.Controller;


import java.io.ByteArrayInputStream;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Security.AuthUtil;
import com.tradingapplication.TradingApplication.Service.PdfDemoService;

@RestController
public class PdfDemoController {

    @Autowired
    private PdfDemoService pdfDemoService;

    @Autowired
    private AuthUtil authUtil;

    @GetMapping("/download-pdf")
    public void downloadPdf(jakarta.servlet.http.HttpServletResponse response) {
        try {
            // Get the currently authenticated user
            String currentUser = authUtil.getCurrentUsername();

            // Generate PDF as a ByteArrayInputStream
            ByteArrayInputStream pdfStream = pdfDemoService.generatePdf(currentUser);

            // Set response headers
            response.setContentType(MediaType.APPLICATION_PDF_VALUE);
            response.setHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=TransactionReport.pdf");

            // Write the PDF stream to the response
            byte[] buffer = pdfStream.readAllBytes();
            response.getOutputStream().write(buffer);
            response.getOutputStream().flush();
        } catch (Exception e) {
            throw new RuntimeException("Error downloading PDF: " + e.getMessage(), e);
        }
    }
}
