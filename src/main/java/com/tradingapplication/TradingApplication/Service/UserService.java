package com.tradingapplication.TradingApplication.Service;


import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserResponseDTO;
import com.tradingapplication.TradingApplication.globalException.UserAlreadyExist;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;



@Service
@Slf4j
public class UserService implements UserServiceInterface{
	
	@Autowired
	UserDetailsRepository userDetailsRepository;
	@Autowired
	private JavaMailSender javaMailSender;

	
	@Override
	public String addNewUser(UserRequestDTO requestDto) {
		
		
		UserLog userlog = new UserLog();
		if(requestDto.getUsername().equals(userlog.getUsername())) {
			throw new UserAlreadyExist("Try Anyother Username . . .");
		}
		userlog.setUsername(requestDto.getUsername());
		userlog.setPassword(requestDto.getPassword());
		
		UserAccountDetails accountDetails = new UserAccountDetails();
		accountDetails.setBalance(0);
		
		
		UserDetails userDetails = new UserDetails();
		userDetails.setName(requestDto.getName().toUpperCase());
		userDetails.setUsername(requestDto.getUsername());
		userDetails.setEmail(requestDto.getEmail());
		userDetails.setMobile(requestDto.getMobile());
		userDetails.setDateOfBirth(requestDto.getDateOfBirth());
		userDetails.setPan(requestDto.getPan().toUpperCase());
		userDetails.setUserAccountDetails(accountDetails);
		userDetails.setUserLog(userlog);
		
	
		userDetailsRepository.save(userDetails);
		
		UserResponseDTO response = new UserResponseDTO();
		response.setUsername(requestDto.getUsername().toUpperCase());		
		return response.getUsername();
	}
	

	@Override
	public String userLogin(UserLog userlog,Model model) {
		String username = userlog.getUsername();
		String password = userlog.getPassword();
		
		
		UserDetails existingUsers=userDetailsRepository.findByUsername(username).orElseThrow(()->new DataNotFoundException("LoginPage"));
				
		if(username.equals(existingUsers.getUserLog().getUsername()) && password.equals(existingUsers.getUserLog().getPassword())) {
			model.addAttribute("balance",existingUsers.getUserAccountDetails().getBalance());
			model.addAttribute("username", existingUsers.getUsername());
			return "redirect:/dashboard";
		}
		return "LoginPage";
						
			
	}


	@Override
	public String sendOtp(UserRequestDTO requestDto,HttpSession session) {
		
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
