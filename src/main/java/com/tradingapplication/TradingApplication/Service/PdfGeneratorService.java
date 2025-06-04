package com.tradingapplication.TradingApplication.Service;



import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Component;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.tradingapplication.TradingApplication.Entity.KycEntity;



@Component
public class PdfGeneratorService {

    public byte[] generateKycPdf(KycEntity entity) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        Document document = new Document();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
            Font labelFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
            Font valueFont = FontFactory.getFont(FontFactory.HELVETICA, 12);

            document.add(new Paragraph("KYC Verification Report", titleFont));
            document.add(new Paragraph("Generated on: " +
                    entity.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))));
            document.add(Chunk.NEWLINE);

            // Verification result
            addLine(document, "Decision", entity.getDecision(), labelFont, valueFont);
            addLine(document, "Confidence", String.format("%.2f", entity.getConfidence()), labelFont, valueFont);
            document.add(Chunk.NEWLINE);

            // User-provided
            document.add(new Paragraph("User Submitted Data", labelFont));
            addLine(document, "Full Name", entity.getUserFullName(), labelFont, valueFont);
            addLine(document, "DOB", entity.getUserDob(), labelFont, valueFont);
            addLine(document, "Gender", entity.getUserGender(), labelFont, valueFont);
            addLine(document, "Nationality", entity.getUserNationality(), labelFont, valueFont);
            addLine(document, "Email", entity.getUserEmail(), labelFont, valueFont);
            addLine(document, "Mobile", entity.getUserMobile(), labelFont, valueFont);
            addLine(document, "Document Type", entity.getUserDocType(), labelFont, valueFont);
            addLine(document, "Document Number", entity.getUserDocNumber(), labelFont, valueFont);
            document.add(Chunk.NEWLINE);

            // Extracted
            document.add(new Paragraph("Extracted Document Data", labelFont));
            addLine(document, "Full Name", entity.getExtractedFullName(), labelFont, valueFont);
            addLine(document, "DOB", entity.getExtractedDob(), labelFont, valueFont);
            addLine(document, "Document Number", entity.getExtractedDocNumber(), labelFont, valueFont);
            addLine(document, "Age", String.valueOf(entity.getExtractedAge()), labelFont, valueFont);
            addLine(document, "Doc Type", entity.getExtractedDocumentType(), labelFont, valueFont);

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return out.toByteArray();
    }

    private void addLine(Document doc, String label, String value, Font labelFont, Font valueFont) throws DocumentException {
        Paragraph p = new Paragraph();
        p.add(new Chunk(label + ": ", labelFont));
        p.add(new Chunk(value != null ? value : "-", valueFont));
        doc.add(p);
    }
}
