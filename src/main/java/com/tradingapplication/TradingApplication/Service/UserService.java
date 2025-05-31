package com.tradingapplication.TradingApplication.Service;

 
import java.io.IOException;    
import java.util.Base64;
import java.util.Map;
import java.util.Random; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Exception.DataNotFoundException;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.UserLogRepository;
import com.tradingapplication.TradingApplication.dto.UpdateRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserLogDTO;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserResponseDTO;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserService implements UserServiceInterface{
	
	@Autowired
	UserLogRepository userlogrepo;
	@Autowired
	UserDetailsRepository userDetailsRepository;
	@Autowired
	private JavaMailSender javaMailSender;

	@Override
	public String validation (UserRequestDTO requestDto,Model model) {		
		log.info("validation service...");
						
		if (userDetailsRepository.existsByUsername(requestDto.getUsername())||requestDto.getUsername().isBlank()) {
		        return "username";
	    }
	    if (userDetailsRepository.existsByEmail(requestDto.getEmail())||requestDto.getEmail().isBlank()) {
		        return "email";	    }
	    
	    if (userDetailsRepository.existsByMobile(requestDto.getMobile())||requestDto.getMobile().isBlank()) {
		        return "mobile";	    
		        }
	    
	    if (userDetailsRepository.existsByPan(requestDto.getPan())||requestDto.getPan().isBlank()) {
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
			
		UserTable userDetails = new UserTable();
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
	public String userLogin(UserLogDTO userlog,Model model,HttpSession session) {
		
		String username = userlog.getUsername();
		String password = userlog.getPassword();	
		System.out.println(username+password);
		if(!userlogrepo.existsByUsername(username)) {
			model.addAttribute("loginError", "USER_NOT_FOUND");
			return "LoginPage";
		}
		if(userlogrepo.existsByUsername(username)) {
			UserLog existingUsers = userlogrepo.findById(username).orElseThrow(()->new DataNotFoundException("User Not Found"));
			if(!password.equals(existingUsers.getPassword())) {
				model.addAttribute("loginError", "PASSWORD_MISMATCH");
				return "LoginPage";
			}
			if(username.equals(existingUsers.getUsername()) && password.equals(existingUsers.getPassword())) {
				model.addAttribute("username", existingUsers.getUsername());
				UserLog userlogg = new UserLog();
			    userlogg.setUsername(userlog.getUsername());
			    userlogg.setPassword(userlog.getPassword());
		        session.setAttribute("userlog", userlogg);
				log.info("user login service sucessfully...");		
				return "redirect:/dashboard";
			}
			}
			Integer attempts = (Integer) session.getAttribute("ATTEMPTS");
		    if (attempts != null && attempts >= 3) {
		        String captchaResponse = userlog.getCaptcha(); // Add this field in UserLog
		        boolean verified = verifyCaptcha(captchaResponse);
		        if (!verified) {
		            model.addAttribute("loginError", "CAPTCHA_FAILED");
		            return "LoginPage";
		        }
		    }
		model.addAttribute("loginError", "USER_NOT_FOUND");
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
		 
		UserTable userdetails = null;
		
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
	public String updatePassword(String password, String emailOrUsername) {

		UserTable userdetails = null;
		
		if(emailOrUsername.contains("@")) {
			userdetails=userDetailsRepository.findByEmail(emailOrUsername).orElseThrow(()->new DataNotFoundException("LoginPage"));
		}
		else{
			userdetails=userDetailsRepository.findByUsername(emailOrUsername).orElseThrow(()->new DataNotFoundException("LoginPage"));
		}
		System.out.println(userdetails.getUserLog().getPassword());
		userdetails.getUserLog().setPassword(password);
		System.out.println(userdetails.getUserLog().getPassword());
		userDetailsRepository.save(userdetails);
		
		return "LoginPage";
	}
	
	@Override
	public String getEditPage(HttpSession session, Model model) {
		UserLog userlog=(UserLog) session.getAttribute("userlog");
		UserTable userdetails=userDetailsRepository.findByUsername(userlog.getUsername()).orElseThrow(()->new DataNotFoundException("LoginPage"));
		model.addAttribute("userDetails",userdetails);
		return "EditProfile";
	}

	@Override
	public String updateData(UpdateRequestDTO requestDto, HttpSession session,Model model) {

		UserLog userlog = (UserLog) session.getAttribute("userlog");
		UserTable user=userDetailsRepository.findByUsername(userlog.getUsername()).orElseThrow(()->new DataNotFoundException("LoginPage"));
		
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
	@Override
	public boolean verifyCaptcha(String captchaResponse) {
		 	String secret = "6Ldl-VArAAAAACpiLeSjvn58qJZbGe-BYOVahFsV";
		    String url = "https://www.google.com/recaptcha/api/siteverify";

		    RestTemplate restTemplate = new RestTemplate();
		    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		    params.add("secret", secret);
		    params.add("response", captchaResponse);

		    Map<String, Object> response = restTemplate.postForObject(url, params, Map.class);
		    return (Boolean) response.get("success");	
	}
}
