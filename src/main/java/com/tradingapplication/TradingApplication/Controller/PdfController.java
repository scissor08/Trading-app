package com.tradingapplication.TradingApplication.Controller;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Service.PdfService; 
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.io.ByteArrayInputStream;

@Controller
@RequestMapping("/pdf")
public class PdfController {

    @Autowired
    private PdfService pdfService;

    @GetMapping("/download")
    public ResponseEntity<byte[]> downloadPdf(HttpSession session) {
        ByteArrayInputStream bis = pdfService.callPdfGenerator(session);

        HttpHeaders headers = new HttpHeaders();
       // headers.add("Content-Disposition", "inline; filename=transactions.pdf"); // for browser view of the pdf
        headers.add("Content-Disposition", "attachment; filename=transactions.pdf");

        return ResponseEntity
                .ok()
                .headers(headers)
                .contentType(MediaType.APPLICATION_PDF)
                .body(bis.readAllBytes());
    }
    
    @GetMapping("/report")
    public String reportJsp(HttpSession session, Model model) {
    	
    	UserLog user = (UserLog) session.getAttribute("userlog");
		if(user!=null) {
			return "reportPdf";
		}
		return "LoginPage";
    	
    	
    	
    	
    	
    }
    
    
    
}



