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

import com.tradingapplication.TradingApplication.Service.UserServiceInterface;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping
@Slf4j
public class UserRegistrationController {

	@Autowired
	UserServiceInterface userService;
	
	@GetMapping("/registration")
	public String getRegistrationPage() {
	    return "RegistrationPage";
	}

	@PostMapping("/validation")
	public String registerUser(@ModelAttribute UserRequestDTO requestDto,HttpSession session,Model model, RedirectAttributes redirectAttributes) {
		session.setAttribute("requestDto",requestDto);
		String result = userService.validation(requestDto, model);
	    if (!"success".equals(result)) {
	        redirectAttributes.addAttribute("error", result); 
	        redirectAttributes.addFlashAttribute("user", requestDto);
	        return "redirect:/registration";
	    }
	    return "forward:/verification"; 
	}
	
	@PostMapping("/verification")
	public String otpPage(HttpSession session) {
		UserRequestDTO requestDto=(UserRequestDTO) session.getAttribute("requestDto");
		boolean result=userService.sendOtp(requestDto, session);
		if(result) {
		return "OTPPage";
		}
		return "RegistrationPage";
	}
	
	@PostMapping("/register")
	public String addUsers(@RequestParam("otp") String otp,HttpSession session,Model model,RedirectAttributes redirectAttributes){
		String givenOtp=(String) session.getAttribute("otp");
		String userOtp = otp;
		
		if(userOtp==null || !userOtp.equals(givenOtp)){
			redirectAttributes.addAttribute("error", "otp-mismatch");
			return "redirect:/OTPPage";
		}
		
		if(userOtp!=null && userOtp.equals(givenOtp)) {
		UserRequestDTO requestDto= (UserRequestDTO) session.getAttribute("requestDto");	
		String message = userService.addNewUser(requestDto);
		model.addAttribute("message",message);
		session.removeAttribute("otp");
		return "Success";
		
		}
		return "RegistrationPage";
	}
	
	@GetMapping("/OTPPage")
	public String showOtpPage() {
	    return "OTPPage"; // JSP page located at /WEB-INF/views/OTPPage.jsp (if using InternalResourceViewResolver)
	}
}
