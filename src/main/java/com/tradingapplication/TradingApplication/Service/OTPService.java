package com.tradingapplication.TradingApplication.Service;

import java.util.Random; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;
import jakarta.servlet.http.HttpSession;

@Service
public class OTPService {

	@Autowired
	private static JavaMailSender javaMailSender;
	
	public static String sendOtp(UserRequestDTO requestDto,HttpSession session) {
		
		 String otp = String.valueOf(100000 + new Random().nextInt(900000));
		 session.setAttribute("otp", otp);
		 
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(requestDto.getEmail());
		message.setSubject("Verify Your Email for Arize Registration");
		message.setText("Dear "+requestDto.getName()+",\r\n"
				+ "\r\n"
				+ "Thank you for registering with Arize – your platform for smarter and faster trading.\r\n"
				+ "\r\n"
				+ "To complete your registration and verify your email address, please enter the following One-Time Password (OTP) on the verification page:\r\n"
				+ "\r\n"
				+ otp);
		javaMailSender.send(message);
		return "OTPPage";
	}
}
