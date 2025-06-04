package com.tradingapplication.TradingApplication.Security;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Repository.UserLogRepository;
import com.tradingapplication.TradingApplication.globalException.DataNotFoundException;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserLogRepository userService;

    @Autowired
    private JwtUtil jwtUtil; // Inject JWT utility class

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
        String username = authentication.getName();
        log.info("Authentication successful for user: {}", username);

        UserLog userEntity = userService.findById(username)
                .orElseThrow(() -> new DataNotFoundException("User Not Found"));

        // Generate JWT token
        String token = jwtUtil.generateToken(username, userEntity.getRole());

        // Remove session-based logic (Optional, JWT is stateless)
        HttpSession session = request.getSession();
        session.setAttribute("userlog", userEntity);
        session.setAttribute("ATTEMPTS", 0);

        Cookie jwtCookie = new Cookie("jwt", token);
        jwtCookie.setHttpOnly(true);
        jwtCookie.setPath("/");
        response.addCookie(jwtCookie);
        
        // Send JSON response instead of redirect
        response.setContentType("application/json");
        response.getWriter().write("{\"token\": \"" + token + "\", \"redirect\": \"/dashboard\"}");
    }
}