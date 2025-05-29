package com.tradingapplication.TradingApplication.Service;


import java.io.IOException;   
import java.util.Base64;
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
import com.tradingapplication.TradingApplication.dto.UpdateRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserResponseDTO;

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
	public String validation (UserRequestDTO requestDto,Model model) {		
		log.info("validation service...");
						
		if (userDetailsRepository.existsByUsername(requestDto.getUsername())) {
		        return "username";
	    }
	    if (userDetailsRepository.existsByEmail(requestDto.getEmail())) {
		        return "email";	    }
	    
	    if (userDetailsRepository.existsByMobile(requestDto.getMobile())) {
		        return "mobile";	    
		        }
	    
	    if (userDetailsRepository.existsByPan(requestDto.getPan())) {
		        return "pan";	    }
		
	    return "success";
	}
	@Override
	public String addNewUser(UserRequestDTO requestDto) {
				
		UserLog userlog = new UserLog();
		
		userlog.setUsername(requestDto.getUsername());
		userlog.setPassword(requestDto.getPassword());
		userlog.setRole("user");
		
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
		log.info("user added...");
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
			log.info("user login service sucessfully...");
			return "redirect:/dashboard";
		}
		return "LoginPage";			
	}

	@Override
	public boolean sendOtp(UserRequestDTO requestDto,HttpSession session) {
		
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
		return true;		
	}
	
	@Override
	public boolean sendOtpToUser(String emailOrUsername,Model model,HttpSession session) {
		 
		UserDetails userdetails = null;
		
		if(emailOrUsername.contains("@") && userDetailsRepository.existsByEmail(emailOrUsername)) {
			userdetails=userDetailsRepository.findByEmail(emailOrUsername).orElseThrow(()->new DataNotFoundException("LoginPage"));
		}
		else if(userDetailsRepository.existsByUsername(emailOrUsername)){
			userdetails=userDetailsRepository.findByUsername(emailOrUsername).orElseThrow(()->new DataNotFoundException("LoginPage"));
		}
		else {
			 model.addAttribute("error", "User not found.");
		       return false; 
		}
		
		
		String otp = String.valueOf(100000 + new Random().nextInt(900000));
		 session.setAttribute("otp", otp);
		 
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(userdetails.getEmail());
		message.setSubject("Verify Your Email for Arize Registration");
		message.setText("Dear "+userdetails.getName()+",\r\n"
				+ "\r\n"
				+ "Thank you for registering with Arize – your platform for smarter and faster trading.\r\n"
				+ "\r\n"
				+ "To complete your registration and verify your email address, please enter the following One-Time Password (OTP) on the verification page:\r\n"
				+ "\r\n"
				+ otp);
		
		javaMailSender.send(message);
		return true;
	}

	@Override
	public String getEditPage(HttpSession session, Model model) {
		UserLog userlog=(UserLog) session.getAttribute("userlog");
		UserDetails userdetails=userDetailsRepository.findByUsername(userlog.getUsername()).orElseThrow(()->new DataNotFoundException("LoginPage"));
		model.addAttribute("userDetails",userdetails);
		return "EditProfile";
	}

	@Override
	public String updateData(UpdateRequestDTO requestDto, HttpSession session,Model model) {

		UserLog userlog = (UserLog) session.getAttribute("userlog");
		UserDetails user=userDetailsRepository.findByUsername(userlog.getUsername()).orElseThrow(()->new DataNotFoundException("LoginPage"));
		
		user.setName(requestDto.getName().toUpperCase());
		user.setEmail(requestDto.getEmail());
		user.setMobile(requestDto.getMobile());
		user.setDateOfBirth(requestDto.getDateOfBirth());
		user.setUsername(requestDto.getUsername());
		user.setPan(requestDto.getPan().toUpperCase());
			
		 if (requestDto.getProfileImage() != null && !requestDto.getProfileImage().isEmpty()) {
		        try {
		        	user.setProfileImage(requestDto.getProfileImage().getBytes());
		        } catch (IOException e) {
					e.printStackTrace();
				}
		    }     
		 byte[] imageBytes = user.getProfileImage();
		 String base64Image = Base64.getEncoder().encodeToString(imageBytes);
		 model.addAttribute("base64Image", base64Image);
				   
		userDetailsRepository.save(user);
		return "redirect:/profile";	
	}
	

}
