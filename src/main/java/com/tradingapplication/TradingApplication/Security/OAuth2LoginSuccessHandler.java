package com.tradingapplication.TradingApplication.Security;

import java.io.IOException;
import java.net.URLEncoder;
import java.time.Duration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.UserLogRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class OAuth2LoginSuccessHandler implements AuthenticationSuccessHandler {

	 @Autowired
	 private UserLogRepository userlogrepo;
	 @Autowired
	 JwtUtil jwtUtil;
	 @Autowired 
	 UserDetailsRepository userDetailRepo;
	 
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication)
            throws IOException, ServletException {

        OAuth2User oauthUser = (OAuth2User) authentication.getPrincipal();
        
        String email = oauthUser.getAttribute("email");
        String[] mail=email.split("@");
        String username=mail[0];
        String role = "USER";
  
		 if(!userDetailRepo.existsByEmail(email)) {	
			 UserLog user = new UserLog();
			 user.setUsername(username);
			 user.setPassword("tempPass");
			 user.setRole(role);
			 userlogrepo.save(user);
		 }
 
		 String token = jwtUtil.generateToken(username, role);
		 
        ResponseCookie jwtCookie = ResponseCookie.from("jwt", token)
                .httpOnly(true)
                .secure(true)
                .sameSite("Strict")
                .maxAge(Duration.ofDays(1))
                .path("/")
                .build();

        response.addHeader(HttpHeaders.SET_COOKIE, jwtCookie.toString());         
        
        if(userDetailRepo.existsByEmail(email)) {	
        	response.sendRedirect("/dashboard");
        	return;
        }
        
        response.sendRedirect("/oauth2/setup-password?name=" + URLEncoder.encode(username, "UTF-8")
        + "&email=" + URLEncoder.encode(email, "UTF-8")
        + "&role=" + URLEncoder.encode(role, "UTF-8"));

    }
}

