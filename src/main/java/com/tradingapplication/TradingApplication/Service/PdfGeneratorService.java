package com.tradingapplication.TradingApplication.Service;

import java.io.ByteArrayOutputStream; 
import java.util.function.Supplier;

import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.tradingapplication.TradingApplication.Entity.KycEntity;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.KycRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Security.AuthUtil;

@Component
public class PdfGeneratorService {

	@Autowired
	private AuthUtil authUtil;

	@Autowired
	private UserDetailsRepository userDetailsRepository;

	@Autowired
	private KycRepository kycRepository;
	public byte[] generateKycPdfForCurrentUser() {
	    String username = authUtil.getCurrentUsername();

	    UserTable user = userDetailsRepository.findByUsername(username)
	            .orElseThrow(() -> new DataNotFoundException("User not found"));

	    // Try to fetch KYC. If not found, just pass null (no throw)
	    KycEntity kyc = kycRepository.findById(user.getUserId()).orElse(null);

	    return generateKycPdf(kyc); // even if null
	}


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
	        String generatedTime = java.time.LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	        document.add(new Paragraph("Generated on: " + generatedTime));
	        document.add(Chunk.NEWLINE);

	        // Decision
	        addLine(document, "Decision", safe(() -> entity.getDecision()), labelFont, valueFont);
	        addLine(document, "Confidence", safe(() -> String.format("%.2f", entity.getConfidence())), labelFont, valueFont);
	        document.add(Chunk.NEWLINE);

	        document.add(new Paragraph("User Submitted Data", labelFont));
	        addLine(document, "Full Name", safe(() -> entity.getUserFullName()), labelFont, valueFont);
	        addLine(document, "DOB", safe(() -> entity.getUserDob()), labelFont, valueFont);
	        addLine(document, "Gender", safe(() -> entity.getUserGender()), labelFont, valueFont);
	        addLine(document, "Nationality", safe(() -> entity.getUserNationality()), labelFont, valueFont);
	        addLine(document, "Email", safe(() -> entity.getUserEmail()), labelFont, valueFont);
	        addLine(document, "Mobile", safe(() -> entity.getUserMobile()), labelFont, valueFont);
	        addLine(document, "Document Type", safe(() -> entity.getUserDocType()), labelFont, valueFont);
	        addLine(document, "Document Number", safe(() -> entity.getUserDocNumber()), labelFont, valueFont);
	        document.add(Chunk.NEWLINE);

	        document.add(new Paragraph("Extracted Document Data", labelFont));
	        addLine(document, "Full Name", safe(() -> entity.getExtractedFullName()), labelFont, valueFont);
	        addLine(document, "DOB", safe(() -> entity.getExtractedDob()), labelFont, valueFont);
	        addLine(document, "Document Number", safe(() -> entity.getExtractedDocNumber()), labelFont, valueFont);
	        addLine(document, "Age", safe(() -> String.valueOf(entity.getExtractedAge())), labelFont, valueFont);
	        addLine(document, "Doc Type", safe(() -> entity.getExtractedDocumentType()), labelFont, valueFont);

	        document.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return out.toByteArray();
	}
	
	private String safe(Supplier<String> supplier) {
	    try {
	        String val = supplier.get();
	        return (val != null && !val.isEmpty()) ? val : "-";
	    } catch (Exception e) {
	        return "-";
	    }
	}



	private void addLine(Document doc, String label, String value, Font labelFont, Font valueFont)
			throws DocumentException {
		Paragraph p = new Paragraph();
		p.add(new Chunk(label + ": ", labelFont));
		p.add(new Chunk(value != null ? value : "-", valueFont));
		doc.add(p);
	}
}
