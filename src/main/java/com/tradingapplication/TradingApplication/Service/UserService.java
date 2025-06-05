package com.tradingapplication.TradingApplication.Service;

import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.UserLogRepository;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserResponseDTO;
import com.tradingapplication.TradingApplication.globalException.DataNotFoundException;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserService implements UserServiceInterface {

	private final PasswordEncoder passwordEncoder;
	private UserDetailsRepository userDetailsRepository;
	private JavaMailSender javaMailSender;

	@Autowired
	public UserService(PasswordEncoder passwordEncoder, UserLogRepository userlogrepo,
			UserDetailsRepository userDetailsRepository, JavaMailSender javaMailSender) {
		super();
		this.passwordEncoder = passwordEncoder;
		this.userDetailsRepository = userDetailsRepository;
		this.javaMailSender = javaMailSender;
	}

	@Override
	public String validation(UserRequestDTO requestDto, Model model) {
		log.info("validation service...");

		if (userDetailsRepository.existsByUsername(requestDto.getUsername()) || requestDto.getUsername().isBlank()) {
			 return "redirect:/arise/registration?error=username";
		}
		else if (userDetailsRepository.existsByEmail(requestDto.getEmail()) || requestDto.getEmail().isBlank()) {
			return "redirect:/arise/registration?error=email";
		}
		else {
			return "forward:/arise/verification";	
		}
	}
	@Override
	public String addNewUser(UserRequestDTO requestDto) {

		UserLog userlog = new UserLog();

		userlog.setUsername(requestDto.getUsername());
		String encodedPassword = passwordEncoder.encode(requestDto.getPassword());
		userlog.setPassword(encodedPassword);
		userlog.setRole("user");

		UserAccountDetails accountDetails = new UserAccountDetails();
		accountDetails.setBalance(0);

		UserTable userDetails = new UserTable();
		userDetails.setName(requestDto.getName().toUpperCase());
		userDetails.setUsername(requestDto.getUsername());
		userDetails.setEmail(requestDto.getEmail());
		userDetails.setUserAccountDetails(accountDetails);
		userDetails.setUserLog(userlog);

		userDetailsRepository.save(userDetails);

		UserResponseDTO response = new UserResponseDTO();
		response.setUsername(requestDto.getUsername().toUpperCase());
		log.info("user added...");
		return response.getUsername();
	}

	@Override
	public boolean sendOtp(UserRequestDTO requestDto, HttpSession session) {

		String otp = String.valueOf(100000 + new Random().nextInt(900000));
		session.setAttribute("otp", otp);

		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(requestDto.getEmail());
		message.setSubject("Verify Your Email for Arize Registration");
		message.setText("Dear " + requestDto.getName() + ",\r\n" + "\r\n"
				+ "Thank you for registering with Arize – your platform for smarter and faster trading.\r\n" + "\r\n"
				+ "To complete your registration and verify your email address, please enter the following One-Time Password (OTP) on the verification page:\r\n"
				+ "\r\n" + otp);

		javaMailSender.send(message);
		return true;
	}

	@Override
	public boolean sendOtpToUser(String emailOrUsername, Model model, HttpSession session) {

		UserTable userdetails = null;

		if (emailOrUsername.contains("@") && userDetailsRepository.existsByEmail(emailOrUsername)) {
			userdetails = userDetailsRepository.findByEmail(emailOrUsername)
					.orElseThrow(() -> new DataNotFoundException("auth/Arise"));
		} else if (userDetailsRepository.existsByUsername(emailOrUsername)) {
			userdetails = userDetailsRepository.findByUsername(emailOrUsername)
					.orElseThrow(() -> new DataNotFoundException("auth/Arise"));
		} else {
			model.addAttribute("error", "User not found.");
			return false;
		}

		String otp = String.valueOf(100000 + new Random().nextInt(900000));
		session.setAttribute("otp", otp);

		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(userdetails.getEmail());
		message.setSubject("Verify Your Email for Arize Registration");
		message.setText("Dear " + userdetails.getName() + ",\r\n" + "\r\n"
				+ "Thank you for registering with Arize – your platform for smarter and faster trading.\r\n" + "\r\n"
				+ "To complete your registration and verify your email address, please enter the following One-Time Password (OTP) on the verification page:\r\n"
				+ "\r\n" + otp);

		javaMailSender.send(message);
		return true;
	}

	@Override
	public String updatePassword(String password, String emailOrUsername) {

		UserTable userdetails = null;

		if (emailOrUsername.contains("@")) {
			userdetails = userDetailsRepository.findByEmail(emailOrUsername)
					.orElseThrow(() -> new DataNotFoundException("auth/Arise"));
		} else {
			userdetails = userDetailsRepository.findByUsername(emailOrUsername)
					.orElseThrow(() -> new DataNotFoundException("auth/Arise"));
		}
		System.out.println(userdetails.getUserLog().getPassword());
		String encodedPassword = passwordEncoder.encode(password);
		userdetails.getUserLog().setPassword(encodedPassword);
		System.out.println(userdetails.getUserLog().getPassword());
		userDetailsRepository.save(userdetails);
		return "auth/Arise?success=password_reset";
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
