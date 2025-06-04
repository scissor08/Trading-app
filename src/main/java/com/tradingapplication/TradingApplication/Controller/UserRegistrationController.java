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
@RequestMapping("/arise")
@Slf4j
public class UserRegistrationController {

    @Autowired
    private UserServiceInterface userService;

    @GetMapping("/registration")
    public String getRegistrationPage() {
        return "auth/Arise";
    }

    @PostMapping("/validation")
    public String registerUser(@ModelAttribute UserRequestDTO requestDto, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        
    	log.info("validation.....................................");
    	session.setAttribute("requestDto", requestDto);
        return userService.validation(requestDto, model);
    }

    @PostMapping("/verification")
    public String otpPage(HttpSession session) {
        UserRequestDTO requestDto = (UserRequestDTO) session.getAttribute("requestDto");
        boolean result = userService.sendOtp(requestDto, session);

        if (result) {
            return "auth/OTPPage";
        }
        return "auth/Arise";
    }

    @PostMapping("/register")
    public String addUsers(@RequestParam("otp") String otp, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        String givenOtp = (String) session.getAttribute("otp");

        if (otp == null || !otp.equals(givenOtp)) {
            redirectAttributes.addFlashAttribute("error", "otp-mismatch");
            return "redirect:/arise/OTPPage";
        }

        UserRequestDTO requestDto = (UserRequestDTO) session.getAttribute("requestDto");
        String message = userService.addNewUser(requestDto);
        model.addAttribute("message", message);

        session.removeAttribute("otp"); 
        return "auth/Success";
    }

    @GetMapping("/OTPPage")
    public String showOtpPage() {
        return "auth/OTPPage";
    }

    @GetMapping("/success")
    public String showSuccessPage() {
        return "auth/Success";
    }
}