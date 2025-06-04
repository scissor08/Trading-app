package com.tradingapplication.TradingApplication.Security;

import java.io.IOException;
import java.time.Duration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
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
    private UserLogRepository userlogrepo;

    @Autowired
    private JwtUtil jwtUtil; 

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
    	HttpSession session = request.getSession();
        session.removeAttribute("failedAttempts");
    	String username = authentication.getName();
        log.info("Authentication successful for user: {}", username);
        
        UserLog userEntity = userlogrepo.findById(username)
                .orElseThrow(() -> new DataNotFoundException("User Not Found"));

        String token = jwtUtil.generateToken(username, userEntity.getRole());
        
        ResponseCookie jwtCookie = ResponseCookie.from("jwt", token)
                .httpOnly(true)
                .secure(true)
                .sameSite("Strict")
                .maxAge(Duration.ofDays(7))
                .path("/")
                .build();

        response.addHeader(HttpHeaders.SET_COOKIE, jwtCookie.toString());
        session.setAttribute("userlog", userEntity);
        
        response.sendRedirect("/dashboard");
    }
}