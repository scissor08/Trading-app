package com.tradingapplication.TradingApplication.Security;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.net.URLEncoder;

@Component
public class OAuth2LoginSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private JwtUtil jwtUtil;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication)
            throws IOException, ServletException {

        OAuth2User oauthUser = (OAuth2User) authentication.getPrincipal();
        
        String email = oauthUser.getAttribute("email");
        String[] mail=email.split("@");
        String name=mail[0];
        String role = "USER";

        response.sendRedirect("/oauth2/setup-password?name=" + URLEncoder.encode(name, "UTF-8")
        + "&email=" + URLEncoder.encode(email, "UTF-8")
        + "&role=" + URLEncoder.encode(role, "UTF-8"));

    }
}

