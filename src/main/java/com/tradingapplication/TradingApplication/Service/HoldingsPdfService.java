package com.tradingapplication.TradingApplication.Service;


import com.itextpdf.kernel.colors.ColorConstants;

import com.itextpdf.kernel.pdf.*;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.*;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import com.itextpdf.io.image.ImageData;
import com.itextpdf.io.image.ImageDataFactory;

import com.itextpdf.layout.Canvas;
import com.itextpdf.kernel.pdf.canvas.PdfCanvas;
import com.tradingapplication.TradingApplication.Entity.Portfolio;


import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
public class HoldingsPdfService {

    @SuppressWarnings("resource")
	public void generateHoldingsPDF(List<Portfolio> holdings, HttpServletResponse response) throws IOException {
        PdfWriter writer = new PdfWriter(response.getOutputStream());
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf);

        PdfPage page = pdf.addNewPage();

        // ✅ Load watermark image from /src/main/resources/static/images/watermark.png
        ImageData imageData = ImageDataFactory.create(getClass().getResource("/static/images/logo.png"));
        Image image = new Image(imageData);
        image.setFixedPosition(150, 300);
        image.setOpacity(0.1f);
        image.setWidth(300);
        new Canvas(new PdfCanvas(page), pdf.getDefaultPageSize()).add(image);

        // ✅ Title
        document.add(new Paragraph("Holdings Report")
            .setTextAlignment(TextAlignment.CENTER)
            .setFontSize(18)
            .setBold()
            .setMarginBottom(20));

        // ✅ Table
        float[] widths = {100, 70, 70, 70, 90, 90, 90};
        Table table = new Table(widths);
        table.setWidth(UnitValue.createPercentValue(100));
        String[] headers = {"Symbol", "Qty", "Buy Price", "Current Price", "Investment", "Current Value", "P/L"};

        for (String header : headers) {
            table.addHeaderCell(new Cell().add(new Paragraph(header).setBold()));
        }

        for (Portfolio h : holdings) {
            double investment = h.getQuantity() * h.getPrice();
            double value = h.getQuantity() * h.getPrice();
            double profit = value - investment;

            table.addCell(h.getSymbol());
            table.addCell(String.valueOf(h.getQuantity()));
            table.addCell("₹" + h.getPrice());
            table.addCell("₹" + h.getPrice());
            table.addCell("₹" + String.format("%.2f", investment));
            table.addCell("₹" + String.format("%.2f", value));
            table.addCell(new Paragraph((profit >= 0 ? "+" : "-") + "₹" + String.format("%.2f", Math.abs(profit)))
                    .setFontColor(profit >= 0 ? ColorConstants.GREEN : ColorConstants.RED));
        }

        document.add(table);
        document.close();
    }
}
