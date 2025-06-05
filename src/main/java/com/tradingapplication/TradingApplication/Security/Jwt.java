package com.tradingapplication.TradingApplication.Security;

import org.springframework.beans.factory.annotation.Autowired;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;

public class Jwt {

	@Autowired
	private JwtUtil jwtUtil;
	
	public String getUsername(HttpServletRequest request) {
	String token = null;

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("jwt".equals(cookie.getName())) {
                token = cookie.getValue();
                break;
            }
        }
    }

    if (token != null && jwtUtil.validateToken(token, jwtUtil.extractUsername(token))) {
        String username = jwtUtil.extractUsername(token);
        return username;
    }
	return null;
	}
}
