package com.tradingapplication.TradingApplication.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tradingapplication.TradingApplication.Service.UserServiceInterface;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/arise")
@Slf4j
public class UserLoginController {

	@Autowired
	private UserServiceInterface service;

	@GetMapping("/login")
	public String showLoginPage() {
		return "auth/Arise";
	}

	@GetMapping("/forget")
	public String getForgetPage() {
		return "auth/ForgetPassword";
	}

	@PostMapping("/uservalidate")
	public String sendOtp(@RequestParam String emailOrUsername, Model model, HttpSession session) {
		session.setAttribute("name", emailOrUsername);
		boolean userExists = service.sendOtpToUser(emailOrUsername, model, session);

		if (userExists) {
			model.addAttribute("otpSent", true);
			return "auth/ForgetPassword";
		} else {
			model.addAttribute("error", "User not found.");
			return "auth/ForgetPassword";
		}
	}

	@PostMapping("/otpvalidate")
	public String otpValidate(@RequestParam("otp") String otp, HttpSession session, Model model) {
		if (!otp.equals(session.getAttribute("otp"))) {
			model.addAttribute("error", "OTP mismatch");
			return "auth/ForgetPassword";
		}

		model.addAttribute("otpVerified", true);
		return "auth/ForgetPassword";
	}

	@PostMapping("/updatePassword")
	public String updatePassword(@RequestParam String password, HttpSession session) {
		return service.updatePassword(password, (String) session.getAttribute("name"));
	}

	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		 Cookie[] cookies = request.getCookies();
		    if (cookies != null) {
		        for (Cookie cookie : cookies) {
		            cookie.setValue(null);
		            cookie.setMaxAge(0);
		            cookie.setPath("/"); 
		            response.addCookie(cookie);
		        }
		    }
		return "redirect:/arise/logout"; 
	}
}