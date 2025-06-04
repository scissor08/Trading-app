package com.tradingapplication.TradingApplication.Service;

import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
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
import com.tradingapplication.TradingApplication.dto.UserLogDTO;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserResponseDTO;
import com.tradingapplication.TradingApplication.globalException.DataNotFoundException;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserService implements UserServiceInterface {

	private final PasswordEncoder passwordEncoder;
	private UserLogRepository userlogrepo;
	private UserDetailsRepository userDetailsRepository;
	private JavaMailSender javaMailSender;
	private AuthenticationManager authenticationManager;

	@Autowired
	public UserService(PasswordEncoder passwordEncoder, UserLogRepository userlogrepo,
			UserDetailsRepository userDetailsRepository, JavaMailSender javaMailSender,
			AuthenticationManager authenticationManager) {
		super();
		this.passwordEncoder = passwordEncoder;
		this.userlogrepo = userlogrepo;
		this.userDetailsRepository = userDetailsRepository;
		this.javaMailSender = javaMailSender;
		this.authenticationManager = authenticationManager;
	}

	@Override
	public String validation(UserRequestDTO requestDto, Model model) {
		log.info("validation service...");

		if (userDetailsRepository.existsByUsername(requestDto.getUsername()) || requestDto.getUsername().isBlank()) {
			return "username";
		}
		return "success";
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
	public String userLogin(UserLogDTO userlog, Model model, HttpSession session) {
	    String username = userlog.getUsername();
	    String password = userlog.getPassword();
	    
	    log.info("=== LOGIN ATTEMPT START ===");
	    log.info("Username: {}", username);
	    log.info("Password length: {}", password != null ? password.length() : 0);
	    log.info("AuthenticationManager: {}", authenticationManager != null ? authenticationManager.getClass().getSimpleName() : "NULL");
	    
	    try {
	        // Step 1: Check if user exists in database first
	        log.info("Step 1: Checking if user exists in database...");
	        UserLog userEntity = userlogrepo.findById(username).orElse(null);
	        if (userEntity == null) {
	            log.warn("User not found in database: {}", username);
	            model.addAttribute("loginError", "USER_NOT_FOUND");
	            return "auth/Arise";
	        }
	        log.info("User found in database: {}", userEntity.getUsername());
	        
	        // Step 2: Create authentication token
	        log.info("Step 2: Creating authentication token...");
	        UsernamePasswordAuthenticationToken authToken = 
	            new UsernamePasswordAuthenticationToken(username, password);
	        log.info("Authentication token created: {}", authToken.getClass().getSimpleName());
	        
	        // Step 3: Attempt authentication
	        log.info("Step 3: Attempting authentication...");
	        Authentication authentication = authenticationManager.authenticate(authToken);
	        log.info("Authentication result: {}", authentication != null ? "SUCCESS" : "NULL");
	        
	        if (authentication != null && authentication.isAuthenticated()) {
	            log.info("Authentication successful for user: {}", authentication.getName());
	            SecurityContext context = SecurityContextHolder.createEmptyContext();
	            context.setAuthentication(authentication);
	            SecurityContextHolder.setContext(context);

	            // Set security context
	            SecurityContextHolder.getContext().setAuthentication(authentication);
	            
	            // Set session attributes for compatibility
	            session.setAttribute("userlog", userEntity);
	            session.setAttribute("ATTEMPTS", 0);
	            
	            log.info("User successfully logged in: {}", username);
	            return "redirect:/dashboard";
	        } else {
	            log.warn("Authentication failed - authentication object is null or not authenticated");
	            model.addAttribute("loginError", "AUTHENTICATION_FAILED");
	        }
	        
	    } catch (UsernameNotFoundException e) {
	        log.error("UsernameNotFoundException for user: {} - {}", username, e.getMessage());
	        model.addAttribute("loginError", "USER_NOT_FOUND");
	    } catch (BadCredentialsException e) {
	        log.error("BadCredentialsException for user: {} - {}", username, e.getMessage());
	        model.addAttribute("loginError", "PASSWORD_MISMATCH");
	    } catch (LockedException e) {
	        log.error("LockedException for user: {} - {}", username, e.getMessage());
	        model.addAttribute("loginError", "ACCOUNT_LOCKED");
	    } catch (DisabledException e) {
	        log.error("DisabledException for user: {} - {}", username, e.getMessage());
	        model.addAttribute("loginError", "ACCOUNT_DISABLED");
	    } catch (Exception e) {
	        log.error("Unexpected authentication error for user: {} - Error: {}", username, e.getMessage());
	        log.error("Full stack trace:", e);
	        model.addAttribute("loginError", "LOGIN_FAILED");
	    }
	    
	    // Handle failed login attempts
	    Integer attempts = (Integer) session.getAttribute("ATTEMPTS");
	    attempts = (attempts == null) ? 1 : attempts + 1;
	    session.setAttribute("ATTEMPTS", attempts);
	    log.info("Failed login attempts for {}: {}", username, attempts);
	    
	    if (attempts >= 3 && !verifyCaptcha(userlog.getCaptcha())) {
	        log.warn("CAPTCHA verification failed for user: {}", username);
	        model.addAttribute("loginError", "CAPTCHA_FAILED");
	    }
	    
	    log.info("=== LOGIN ATTEMPT END (FAILED) ===");
	    return "auth/Arise";
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

		return "auth/Arise";
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
