package com.tradingapplication.TradingApplication.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.colors.DeviceRgb;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.geom.Rectangle;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfPage;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.PdfCanvas;
import com.itextpdf.kernel.pdf.extgstate.PdfExtGState;
import com.itextpdf.layout.Canvas;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.borders.Border;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.HorizontalAlignment;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import com.itextpdf.layout.properties.VerticalAlignment;

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
    
    // Color scheme
    private static final DeviceRgb HEADER_COLOR = new DeviceRgb(41, 128, 185);
    private static final DeviceRgb ACCENT_COLOR = new DeviceRgb(52, 152, 219);
    private static final DeviceRgb WATERMARK_COLOR = new DeviceRgb(240, 240, 240);
    
    
    public ByteArrayInputStream callPdfGenerator(HttpSession session) {
    	 UserLog getuser = (UserLog) session.getAttribute("userlog");
         UserDetails getuserName = userDetailsRepository.findByUsername(getuser.getUsername())
                 .orElseThrow(() -> new DataNotFoundException("No such user found"));
         
         
    	
		return generatePdf(getuserName);
    	
    }
    
    
    public ByteArrayInputStream generatePdf(UserDetails getuserName ) {
        try {
        	int id = getuserName.getUserId();
            List<TransactionBuySell> data = transactionRepository.findAllByUser_Id(id);
            
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            PdfWriter writer = new PdfWriter(out);
            PdfDocument pdf = new PdfDocument(writer);
            Document document = new Document(pdf, PageSize.A4);
            document.setMargins(40, 40, 40, 40);
            
            // Set up fonts
            PdfFont boldFont = PdfFontFactory.createFont();
            PdfFont regularFont = PdfFontFactory.createFont();
            
            // Add watermark to each page
            addWatermark(pdf, "TRADING REPORT");
            
            // Header Section
            addHeader(document, boldFont, getuserName);
            
            // Summary Section
            addSummarySection(document, data, boldFont, regularFont);
            
            // Transaction Table
            addTransactionTable(document, data, boldFont, regularFont);
            
            // Footer
            addFooter(document, regularFont);
            
            document.close();
            return new ByteArrayInputStream(out.toByteArray());
            
        } catch (Exception e) {
            throw new RuntimeException("Error generating PDF: " + e.getMessage(), e);
        }
    }
    
    private void addWatermark(PdfDocument pdf, String watermarkText) {
        try {
            PdfFont font = PdfFontFactory.createFont();
            
            for (int i = 1; i <= pdf.getNumberOfPages(); i++) {
                PdfPage page = pdf.getPage(i);
                Rectangle pageSize = page.getPageSize();
                PdfCanvas pdfCanvas = new PdfCanvas(page.newContentStreamBefore(), page.getResources(), pdf);
                
                // Set transparency
                PdfExtGState gState = new PdfExtGState();
                gState.setFillOpacity(0.5f);
                pdfCanvas.setExtGState(gState);
                
                // Calculate center position
                float x = pageSize.getWidth() / 2;
                float y = pageSize.getHeight() / 2;
                
                // Draw watermark directly on canvas
                pdfCanvas.saveState()
                        .setFillColor(WATERMARK_COLOR)
                        .beginText()
                        .setFontAndSize(font, 60)
                        .setTextMatrix((float) Math.cos(Math.toRadians(45)), 
                                      (float) Math.sin(Math.toRadians(45)), 
                                      (float) -Math.sin(Math.toRadians(45)), 
                                      (float) Math.cos(Math.toRadians(45)), 
                                      x - (watermarkText.length() * 15), y)
                        .showText(watermarkText)
                        .endText()
                        .restoreState();
            }
        } catch (Exception e) {
            // Log error but don't fail PDF generation
            System.err.println("Error adding watermark: " + e.getMessage());
        }
    }
    
    private void addHeader(Document document, PdfFont boldFont, UserDetails userDetails) {
        try {
            // Company/App Name
            Paragraph title = new Paragraph("TRADING APPLICATION")
                    .setFont(boldFont)
                    .setFontSize(24)
                    .setFontColor(HEADER_COLOR)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(5);
            document.add(title);
            
            // Report Title
            Paragraph reportTitle = new Paragraph("Stock Transaction Report")
                    .setFont(boldFont)
                    .setFontSize(18)
                    .setFontColor(ACCENT_COLOR)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(20);
            document.add(reportTitle);
            
            // User Information Table
            Table userInfoTable = new Table(2);
            userInfoTable.setWidth(UnitValue.createPercentValue(100));
            
            addInfoRow(userInfoTable, "User ID:", String.valueOf(userDetails.getUserId()), boldFont);
            addInfoRow(userInfoTable, "Username:", userDetails.getUsername(), boldFont);
            addInfoRow(userInfoTable, "Report Generated:", 
                      LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy, HH:mm")), boldFont);
            
            document.add(userInfoTable);
            document.add(new Paragraph("\n"));
            
        } catch (Exception e) {
            throw new RuntimeException("Error adding header: " + e.getMessage(), e);
        }
    }
    
    private void addInfoRow(Table table, String label, String value, PdfFont boldFont) {
        Cell labelCell = new Cell().add(new Paragraph(label).setFont(boldFont).setFontSize(10))
                .setBorder(Border.NO_BORDER)
                .setPadding(5);
        Cell valueCell = new Cell().add(new Paragraph(value).setFontSize(10))
                .setBorder(Border.NO_BORDER)
                .setPadding(5);
        
        table.addCell(labelCell);
        table.addCell(valueCell);
    }
    
    private void addSummarySection(Document document, List<TransactionBuySell> data, 
                                  PdfFont boldFont, PdfFont regularFont) {
        try {
            Paragraph summaryTitle = new Paragraph("Transaction Summary")
                    .setFont(boldFont)
                    .setFontSize(14)
                    .setFontColor(HEADER_COLOR)
                    .setMarginBottom(10);
            document.add(summaryTitle);
            
            // Calculate summary statistics
            int totalTransactions = data.size();
            int buyTransactions = (int) data.stream().filter(t -> "BUY".equalsIgnoreCase(t.getTransactionType())).count();
            int sellTransactions = totalTransactions - buyTransactions;
            double totalAmount = data.stream().mapToDouble(TransactionBuySell::getTotalAmount).sum();
            double buyAmount = data.stream()
                    .filter(t -> "BUY".equalsIgnoreCase(t.getTransactionType()))
                    .mapToDouble(TransactionBuySell::getTotalAmount).sum();
            double sellAmount = totalAmount - buyAmount;
            
            // Summary table
            float[] summaryColumnWidths = {1, 1, 1, 1};
            Table summaryTable = new Table(summaryColumnWidths);
            summaryTable.setWidth(UnitValue.createPercentValue(100));
            summaryTable.setMarginBottom(20);
            
            // Header row
            addSummaryHeaderCell(summaryTable, "Total Transactions", boldFont);
            addSummaryHeaderCell(summaryTable, "Buy Orders", boldFont);
            addSummaryHeaderCell(summaryTable, "Sell Orders", boldFont);
            addSummaryHeaderCell(summaryTable, "Total Amount", boldFont);
            
            // Data row
            addSummaryDataCell(summaryTable, String.valueOf(totalTransactions), regularFont);
            addSummaryDataCell(summaryTable, String.valueOf(buyTransactions), regularFont);
            addSummaryDataCell(summaryTable, String.valueOf(sellTransactions), regularFont);
            addSummaryDataCell(summaryTable, String.format("₹%.2f", totalAmount), regularFont);
            
            document.add(summaryTable);
            
        } catch (Exception e) {
            throw new RuntimeException("Error adding summary section: " + e.getMessage(), e);
        }
    }
    
    private void addSummaryHeaderCell(Table table, String text, PdfFont font) {
        Cell cell = new Cell().add(new Paragraph(text).setFont(font).setFontSize(10))
                .setBackgroundColor(HEADER_COLOR)
                .setFontColor(ColorConstants.WHITE)
                .setTextAlignment(TextAlignment.CENTER)
                .setPadding(8);
        table.addHeaderCell(cell);
    }
    
    private void addSummaryDataCell(Table table, String text, PdfFont font) {
        Cell cell = new Cell().add(new Paragraph(text).setFont(font).setFontSize(10))
                .setTextAlignment(TextAlignment.CENTER)
                .setPadding(8);
        table.addCell(cell);
    }
    
    private void addTransactionTable(Document document, List<TransactionBuySell> data, 
                                   PdfFont boldFont, PdfFont regularFont) {
        try {
            Paragraph tableTitle = new Paragraph("Transaction Details")
                    .setFont(boldFont)
                    .setFontSize(14)
                    .setFontColor(HEADER_COLOR)
                    .setMarginBottom(10);
            document.add(tableTitle);
            
            // Create table with proper column widths
            float[] columnWidths = {80F, 100F, 100F, 50F, 70F, 80F, 60F};
            Table table = new Table(columnWidths);
            table.setWidth(UnitValue.createPercentValue(100));
            
            // Add headers
            addTableHeaderCell(table, "Order ID", boldFont);
            addTableHeaderCell(table, "Date & Time", boldFont);
            addTableHeaderCell(table, "Stock Name", boldFont);
            addTableHeaderCell(table, "Qty", boldFont);
            addTableHeaderCell(table, "Price", boldFont);
            addTableHeaderCell(table, "Total", boldFont);
            addTableHeaderCell(table, "Type", boldFont);
            
            // Add data rows
            SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy\nHH:mm");
            for (TransactionBuySell tx : data) {
                addTableDataCell(table, tx.getOrderId(), regularFont, TextAlignment.LEFT);
                addTableDataCell(table, sdf.format(tx.getTransactionTime()), regularFont, TextAlignment.CENTER);
                addTableDataCell(table, tx.getStockName(), regularFont, TextAlignment.LEFT);
                addTableDataCell(table, String.valueOf(tx.getNoOfStocks()), regularFont, TextAlignment.CENTER);
                addTableDataCell(table, String.format("₹%.2f", tx.getCurrentPrice()), regularFont, TextAlignment.RIGHT);
                addTableDataCell(table, String.format("₹%.2f", tx.getTotalAmount()), regularFont, TextAlignment.RIGHT);
                
                // Color code transaction type
                Cell typeCell = new Cell().add(new Paragraph(tx.getTransactionType()).setFont(regularFont).setFontSize(9))
                        .setTextAlignment(TextAlignment.CENTER)
                        .setPadding(5);
                
                if ("BUY".equalsIgnoreCase(tx.getTransactionType())) {
                    typeCell.setBackgroundColor(new DeviceRgb(46, 204, 113));
                    typeCell.setFontColor(ColorConstants.WHITE);
                } else if ("SELL".equalsIgnoreCase(tx.getTransactionType())) {
                    typeCell.setBackgroundColor(new DeviceRgb(231, 76, 60));
                    typeCell.setFontColor(ColorConstants.WHITE);
                }
                
                table.addCell(typeCell);
            }
            
            document.add(table);
            
        } catch (Exception e) {
            throw new RuntimeException("Error adding transaction table: " + e.getMessage(), e);
        }
    }
    
    private void addTableHeaderCell(Table table, String text, PdfFont font) {
        Cell cell = new Cell().add(new Paragraph(text).setFont(font).setFontSize(10))
                .setBackgroundColor(HEADER_COLOR)
                .setFontColor(ColorConstants.WHITE)
                .setTextAlignment(TextAlignment.CENTER)
                .setPadding(8);
        table.addHeaderCell(cell);
    }
    
    private void addTableDataCell(Table table, String text, PdfFont font, TextAlignment alignment) {
        Cell cell = new Cell().add(new Paragraph(text).setFont(font).setFontSize(9))
                .setTextAlignment(alignment)
                .setPadding(5);
        table.addCell(cell);
    }
    
    private void addFooter(Document document, PdfFont regularFont) {
        try {
            document.add(new Paragraph("\n"));
            
            Paragraph footer = new Paragraph("This is a system-generated report. No signature is required.")
                    .setFont(regularFont)
                    .setFontSize(8)
                    .setFontColor(ColorConstants.GRAY)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginTop(20);
            
            document.add(footer);
            
            Paragraph timestamp = new Paragraph("Generated on: " + 
                    LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMMM yyyy 'at' HH:mm:ss")))
                    .setFont(regularFont)
                    .setFontSize(8)
                    .setFontColor(ColorConstants.GRAY)
                    .setTextAlignment(TextAlignment.CENTER);
            
            document.add(timestamp);
            
        } catch (Exception e) {
            throw new RuntimeException("Error adding footer: " + e.getMessage(), e);
        }
    }
}