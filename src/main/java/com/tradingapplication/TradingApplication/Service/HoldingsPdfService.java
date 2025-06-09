package com.tradingapplication.TradingApplication.Service;

import com.itextpdf.io.image.ImageData;
import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.pdf.*;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.*;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import com.tradingapplication.TradingApplication.Entity.Portfolio;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.PortfolioRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Security.AuthUtil;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class HoldingsPdfService {

    @Autowired
    private PortfolioRepository portfolioRepository;

    @Autowired
    private UserDetailsRepository userRepo;

    @Autowired
    private AuthUtil authUtil;

    public ByteArrayInputStream generateHoldingsReport(HttpSession session) {
        UserTable user = userRepo.findByUsername(authUtil.getCurrentUsername())
                .orElseThrow(() -> new DataNotFoundException("User not found"));

        List<Portfolio> holdings = portfolioRepository.findByUser(user);
        return createPdf(user, holdings);
    }

    private ByteArrayInputStream createPdf(UserTable user, List<Portfolio> holdings) {
        try (ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            PdfWriter writer = new PdfWriter(out);
            PdfDocument pdf = new PdfDocument(writer);
            Document document = new Document(pdf);

            // Title
            Paragraph title = new Paragraph("Holdings Report")
                    .setFontSize(18)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setBold()
                    .setFontColor(ColorConstants.BLUE);
            document.add(title);

            // User Info
            document.add(new Paragraph("User ID: " + user.getUserId()));
            document.add(new Paragraph("Username: " + user.getUsername()));
            document.add(new Paragraph("Generated: " +
                    java.time.LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"))));
            document.add(new Paragraph("\n"));

            // Holdings Table
            Table table = new Table(UnitValue.createPercentArray(new float[]{2, 2, 2, 2}))
                    .useAllAvailableWidth();

            table.addHeaderCell(new Cell().add(new Paragraph("Symbol")).setBackgroundColor(ColorConstants.LIGHT_GRAY).setBold());
            table.addHeaderCell(new Cell().add(new Paragraph("Quantity")).setBackgroundColor(ColorConstants.LIGHT_GRAY).setBold());
            table.addHeaderCell(new Cell().add(new Paragraph("Price")).setBackgroundColor(ColorConstants.LIGHT_GRAY).setBold());
            table.addHeaderCell(new Cell().add(new Paragraph("Transaction Amount")).setBackgroundColor(ColorConstants.LIGHT_GRAY).setBold());


            for (Portfolio p : holdings) {
                table.addCell(p.getSymbol());
                table.addCell(String.valueOf(p.getQuantity()));
                table.addCell("₹" + String.format("%.2f", p.getPrice()));
                table.addCell("₹" + String.format("%.2f", p.getTrancationAmount()));
            }

            document.add(table);
            document.add(new Paragraph("\nThis is a system-generated report."));

            document.close();
            return new ByteArrayInputStream(out.toByteArray());
        } catch (Exception e) {
            throw new RuntimeException("Error generating Holdings PDF", e);
        }
    }
}
