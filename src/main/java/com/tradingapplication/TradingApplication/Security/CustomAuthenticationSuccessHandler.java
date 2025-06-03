package com.tradingapplication.TradingApplication.Security;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Repository.UserLogRepository;
import com.tradingapplication.TradingApplication.globalException.DataNotFoundException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    
    @Autowired
    private UserLogRepository userService; // Your service to get user details
    
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, 
                                      HttpServletResponse response, 
                                      Authentication authentication) throws IOException {
        
        String username = authentication.getName();
        log.info("Authentication successful for user: {}", username);
        
        // Get your UserLog entity
        UserLog userEntity = userService.findById(username).orElseThrow(()->new DataNotFoundException("User Not Found"));
        
        // Set session attributes
        HttpSession session = request.getSession();
        session.setAttribute("userlog", userEntity);
        session.setAttribute("ATTEMPTS", 0);
        
        log.info("User successfully logged in: {}", username);
        
        // Redirect to dashboard
        response.sendRedirect("/dashboard");
    }
}
