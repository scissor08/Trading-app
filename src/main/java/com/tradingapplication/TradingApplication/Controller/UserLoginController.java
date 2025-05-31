package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;     
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Service.CaptchaValidator;
import com.tradingapplication.TradingApplication.Service.UserServiceInterface;
import com.tradingapplication.TradingApplication.dto.UpdateRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserLogDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class UserLoginController {

	@Autowired
	UserServiceInterface service;
	
	@GetMapping("/login")
	public String getRegistrationPage() {
	    return "LoginPage";
	}
		
	@PostMapping("/login")
	public String getDashboard(  @RequestParam String username,
		    @RequestParam String password,
		    @RequestParam(name = "g-recaptcha-response", required = false) String captcha,
		    HttpSession session,
		    Model model) {
	
		UserLogDTO userlog=new UserLogDTO();
		userlog.setUsername(username);
		userlog.setPassword(password);
		userlog.setCaptcha(captcha);
		
		int attempts = session.getAttribute("ATTEMPTS") == null ? 0 : (int) session.getAttribute("ATTEMPTS");
		  
		    boolean validCaptcha = true;

		    if (attempts >= 2) {
		        String captchaResponse = userlog.getCaptcha();
		        validCaptcha = CaptchaValidator.verify(captchaResponse);
		    }

		    if (!validCaptcha) {
		    	model.addAttribute("error", "CAPTCHA_FAILED");
		    	return "LoginPage";
		    }    
		    
		model.addAttribute("Username", userlog.getUsername());
		String loginResult = service.userLogin(userlog, model, session); // pass session

	    // If login failed, increase attempts
	    if (loginResult.equals("LoginPage")) {
	        session.setAttribute("ATTEMPTS", ++attempts);
	    } else {
	        // Reset attempts on successful login
	        session.setAttribute("ATTEMPTS", 0);
	        
	        return loginResult;
	    }
		return service.userLogin(userlog, model, session);
	}
	
	@GetMapping("/forget")
	public String getforgetPage() {
		return "ForgetPassword";
	}
	
	@PostMapping("/uservalidate")
	public String sendOtp(@RequestParam String emailOrUsername, Model model,HttpSession session) {
		session.setAttribute("name", emailOrUsername);
		boolean userExists = service.sendOtpToUser(emailOrUsername, model, session);
	    
	    if (userExists) {
	        model.addAttribute("emailOrUsername", emailOrUsername);
	        model.addAttribute("otpSent", true);
	        return "ForgetPassword"; 
	    } else {
	        model.addAttribute("error", "User not found.");
	        return "ForgetPassword"; 
	    }
	}
	@PostMapping("/otpvalidate")
	public String otpValidat(@RequestParam("otp") String otp,HttpSession session,Model model,RedirectAttributes redirectAttributes) {
	String givenOtp=(String) session.getAttribute("otp");
	String userOtp = otp;
	
	if(userOtp==null || !userOtp.equals(givenOtp)){
		model.addAttribute("error", "otp-mismatch");
		return "ForgetPassword";
	}
	
	if(userOtp!=null && userOtp.equals(givenOtp)) {
		model.addAttribute("otpVerified", true);
	return "ForgetPassword";
	
	}
	return "RegistrationPage";
	}
	
	@PostMapping("/updatePassword")
	public String upadatePassword(@RequestParam String password,HttpSession session,Model model) {
		String emailOrUsername=(String) session.getAttribute("name");
		return service.updatePassword(password,emailOrUsername);
	}
	
	@GetMapping("/update")
	public String getUpdatePage(HttpSession session,Model model) {
		UserLog user=(UserLog)session.getAttribute("userlog");
		if(user!=null) {
			return service.getEditPage(session,model);
		}
		return "LoginPage";
	}
	
	@PostMapping("/update")
	public String update(HttpSession session,@ModelAttribute UpdateRequestDTO requestDto,Model model) {
		UserLog user=(UserLog) session.getAttribute("userlog");
		 if(user!=null) {
			return service.updateData(requestDto,session,model);
		}
		return "LoginPage";
	}
}
