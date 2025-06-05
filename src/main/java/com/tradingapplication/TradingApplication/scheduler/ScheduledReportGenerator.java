package com.tradingapplication.TradingApplication.scheduler;

import java.io.File; 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Service.PdfService;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.core.io.FileSystemResource;


@Service
public class ScheduledReportGenerator {

	@Autowired
	private PdfService pdfService;

	@Autowired
	private UserDetailsRepository userDetailsRepository;
	@Autowired
	private JavaMailSender mailSender;

	@Scheduled(cron = "0 32 22 * * ?") // Time : 
	public void sendScheduledReport() throws Exception {
	
		List<UserTable> getAllUserName = userDetailsRepository.findAll();

		Map<String, File> reportMap = new HashMap<>();

		for (UserTable obj : getAllUserName) {

			byte[] data = pdfService.generatePdf(obj).readAllBytes();
			File pdfFile = ScheduledReportGenerator.convertByteArrayToFile(data, "growthReport.pdf");

			reportMap.put(obj.getEmail(), pdfFile);
			
			sendReports(reportMap);
			
			deletePdf(pdfFile);

		}
		
		
		
		
	}	
	
	 private void sendReports(Map<String, File> reportMap) throws MessagingException {
	        for (Map.Entry<String, File> entry : reportMap.entrySet()) {
	            String email = entry.getKey();
	            File pdf = entry.getValue();

	            MimeMessage message = mailSender.createMimeMessage();
	            MimeMessageHelper helper = new MimeMessageHelper(message, true);

	            helper.setTo(email);
	            helper.setSubject("Your Daily Trading Report");
	            helper.setText("Hello,\n\nPlease find your personalized trading report attached.\n\nRegards,\nTrading Advisor");

	            helper.addAttachment("growthReport.pdf", new FileSystemResource(pdf));
	            mailSender.send(message);
	        }
	    }
	
	
	

	public static File convertByteArrayToFile(byte[] byteArray, String filePath) throws IOException {
		File file = new File(filePath);
		try (FileOutputStream fos = new FileOutputStream(file)) {
			fos.write(byteArray);
		}
		return file;
	}
	
	public void deletePdf(File pdfFile) {
		if (pdfFile != null || pdfFile.exists()) {
			
			pdfFile.delete();
			
		}
	}

}
