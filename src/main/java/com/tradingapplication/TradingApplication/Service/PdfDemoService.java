package com.tradingapplication.TradingApplication.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itextpdf.kernel.colors.DeviceRgb;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfPage;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.PdfCanvas;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Image;
import com.itextpdf.io.image.ImageData;
import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.pdf.extgstate.PdfExtGState;
import com.tradingapplication.TradingApplication.Entity.TransactionBuySell;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Repository.TransactionRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Security.AuthUtil;

@Service
public class PdfDemoService {

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private UserDetailsRepository userDetailsRepository;

    @Autowired
    AuthUtil authUtil;

    private static final DeviceRgb HEADER_COLOR = new DeviceRgb(41, 128, 185);
    private static final DeviceRgb ACCENT_COLOR = new DeviceRgb(52, 152, 219);

 // Add watermark with image (centered with transparency)
    private void addWatermark(PdfDocument pdf, String imagePath, float width, float height, float opacity) {
        try {
            // Load the watermark image
            ImageData imageData = ImageDataFactory.create(imagePath);
            
            // Create image object from ImageData
            Image watermark = new Image(imageData);
            watermark.scaleToFit(width, height);  // Scale the image to the given size

            // Loop through all pages and apply the watermark
            for (int i = 1; i <= pdf.getNumberOfPages(); i++) {
                PdfPage page = pdf.getPage(i);
                PdfCanvas pdfCanvas = new PdfCanvas(page);

                // Set transparency
                PdfExtGState gs1 = new PdfExtGState();
                gs1.setFillOpacity(opacity);  // e.g., 0.3f for 30% opacity
                pdfCanvas.setExtGState(gs1);

                // Position the watermark at the center of the page
                float x = (page.getPageSize().getWidth() - watermark.getImageScaledWidth()) / 2;
                float y = (page.getPageSize().getHeight() - watermark.getImageScaledHeight()) / 2;

                // Set the watermark position
                watermark.setFixedPosition(x, y);

                // Add the watermark to the page
                Document document = new Document(pdf);
                document.add(watermark);

                pdfCanvas.restoreState();
            }
        } catch (Exception e) {
            System.err.println("Error adding image watermark: " + e.getMessage());
        }
    }


    public ByteArrayInputStream generatePdf(String getUserName) {
        try {
            // Get user ID from the user object
        	UserTable findId = userDetailsRepository.findByUsername(getUserName).orElseThrow(()-> new DataNotFoundException("User not found"));
        	
        
            int id = 	findId.getUserId();
            
            List<TransactionBuySell> data = transactionRepository.findAllByUser_Id(id);

            // Output stream for the generated PDF
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            PdfWriter writer = new PdfWriter(out);
            PdfDocument pdf = new PdfDocument(writer);
            Document document = new Document(pdf);

            // Set page size and margins
            document.setMargins(40, 40, 40, 40);

            // Define the watermark image path
            String imagePath = "src/main/resources/static/images/logo.png";  // Ensure this path is correct

            // Add watermark (size 200x100 with 30% opacity)
            addWatermark(pdf, imagePath, 200f, 100f, 0.3f);

            // Add the header, summary, transaction table, and footer
            addHeader(document, PdfFontFactory.createFont(), getUserName);
            addSummarySection(document, data, PdfFontFactory.createFont(), PdfFontFactory.createFont());
            addTransactionTable(document, data, PdfFontFactory.createFont(), PdfFontFactory.createFont());
            addFooter(document, PdfFontFactory.createFont());

            // Close the document and return the generated PDF
            document.close();
            return new ByteArrayInputStream(out.toByteArray());

        } catch (Exception e) {
            throw new RuntimeException("Error generating PDF: " + e.getMessage(), e);
        }
    }

  

	// Method to add header (you can customize this)
    private void addHeader(Document document, com.itextpdf.kernel.font.PdfFont font, String getUserName) {
        document.add(new com.itextpdf.layout.element.Paragraph("Transaction Report")
                .setFont(font)
                .setFontSize(18)
                .setBold()
                .setTextAlignment(com.itextpdf.layout.properties.TextAlignment.CENTER));
    }

    // Method to add summary section
    private void addSummarySection(Document document, List<TransactionBuySell> data, com.itextpdf.kernel.font.PdfFont headerFont, com.itextpdf.kernel.font.PdfFont bodyFont) {
        // Add summary logic here (example)
        document.add(new com.itextpdf.layout.element.Paragraph("Summary Section")
                .setFont(headerFont)
                .setFontSize(12)
                .setBold()
                .setTextAlignment(com.itextpdf.layout.properties.TextAlignment.LEFT));

        // Add further content to the summary
        document.add(new com.itextpdf.layout.element.Paragraph("Summary of transactions for user..."));
    }

    // Method to add transaction table
    private void addTransactionTable(Document document, List<TransactionBuySell> data, com.itextpdf.kernel.font.PdfFont headerFont, com.itextpdf.kernel.font.PdfFont bodyFont) {
        // Example: Create a table for transaction data
        com.itextpdf.layout.element.Table table = new com.itextpdf.layout.element.Table(4);  // Adjust columns as needed

        // Add table header
        table.addHeaderCell(new com.itextpdf.layout.element.Cell().add(new com.itextpdf.layout.element.Paragraph("Date").setFont(headerFont)));
        table.addHeaderCell(new com.itextpdf.layout.element.Cell().add(new com.itextpdf.layout.element.Paragraph("Amount").setFont(headerFont)));
        table.addHeaderCell(new com.itextpdf.layout.element.Cell().add(new com.itextpdf.layout.element.Paragraph("Type").setFont(headerFont)));
        table.addHeaderCell(new com.itextpdf.layout.element.Cell().add(new com.itextpdf.layout.element.Paragraph("Status").setFont(headerFont)));

        // Add rows with transaction data
        for (TransactionBuySell transaction : data) {
            
            table.addCell(new com.itextpdf.layout.element.Cell().add(new com.itextpdf.layout.element.Paragraph(String.valueOf(transaction.getTotalAmount())).setFont(bodyFont)));
          
        }

        // Add the table to the document
        document.add(table);
    }

    // Method to add footer (you can customize this)
    private void addFooter(Document document, com.itextpdf.kernel.font.PdfFont font) {
        document.add(new com.itextpdf.layout.element.Paragraph("Generated on: " + java.time.LocalDate.now())
                .setFont(font)
                .setFontSize(10)
                .setTextAlignment(com.itextpdf.layout.properties.TextAlignment.CENTER));
    }
}
