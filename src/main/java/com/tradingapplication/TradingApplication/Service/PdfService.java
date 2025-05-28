package com.tradingapplication.TradingApplication.Service;




import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.tradingapplication.TradingApplication.Entity.TransactionBuySell;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.TransactionRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;

import jakarta.servlet.http.HttpSession;

@Service
public class PdfService {
	
	@Autowired
	private TransactionRepository transactionRepository;
@Autowired
	private UserDetailsRepository userDetailsRepository;

    public  ByteArrayInputStream generatePdf(HttpSession session) {
    	
    	
       UserLog getuser= (UserLog) session.getAttribute("userlog");
       
       UserDetails getuserName = userDetailsRepository.findByUsername(getuser.getUsername()).orElseThrow(()-> new DataNotFoundException ("not such user found"));
       
       int id = getuserName.getUserId();
       
       List<TransactionBuySell> data = transactionRepository.findAllByUser_Id(id);
  
    	
    	
    	
    	
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        PdfWriter writer = new PdfWriter(out);
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf);

        document.add(new Paragraph("Stock Transaction Report").setBold().setFontSize(18));

        float[] columnWidths = {100F, 120F, 80F, 60F, 80F, 80F, 80F};
        Table table = new Table(columnWidths);

        table.addHeaderCell("Order ID");
        table.addHeaderCell("Transaction Time");
        table.addHeaderCell("Stock Name");
        table.addHeaderCell("Qty");
        table.addHeaderCell("Price");
        table.addHeaderCell("Total");
        table.addHeaderCell("Type");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        for (TransactionBuySell tx : data) {
            table.addCell(tx.getOrderId());
            table.addCell(sdf.format(tx.getTransactionTime()));
            table.addCell(tx.getStockName());
            table.addCell(String.valueOf(tx.getNoOfStocks()));
            table.addCell(String.format("%.2f", tx.getCurrentPrice()));
            table.addCell(String.format("%.2f", tx.getTotalAmount()));
            table.addCell(tx.getTransactionType());
        }

        document.add(table);
        document.close();

        return new ByteArrayInputStream(out.toByteArray());
    }
}
