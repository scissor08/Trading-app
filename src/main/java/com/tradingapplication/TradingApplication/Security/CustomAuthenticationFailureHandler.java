package com.tradingapplication.TradingApplication.Security;

import java.io.IOException;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException {
	    HttpSession session = request.getSession();
		Integer failedAttempts = (Integer) session.getAttribute("failedAttempts");

        if (failedAttempts == null) {
            failedAttempts = 0;
        }

        failedAttempts++;

        session.setAttribute("failedAttempts", failedAttempts);

        if (failedAttempts >= 3) {
            response.sendRedirect("/arise/login?error=CAPTCHA_REQUIRED");
        } else {
            response.sendRedirect("/arise/login?error=INVALID_CREDENTIALS");
        }
 
	    
    }
}
