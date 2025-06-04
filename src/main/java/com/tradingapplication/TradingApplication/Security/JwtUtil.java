package com.tradingapplication.TradingApplication.Security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.Base64;

@Component
public class JwtUtil {
    
    @Value("${jwt.secret}")
    private String secretKey;

    @Value("${jwt.expiration}")
    private long expirationTime;

    @Value("${jwt.issuer}")
    private String issuer;

    // Generate JWT Token
    public String generateToken(String username, String role) {
        return Jwts.builder()
                .setSubject(username)
                .claim("role", role)  // Store role-based access
                .setIssuer(issuer)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + expirationTime))
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();
    }

    // Extract Username from JWT
    public String extractUsername(String token) {
        return getClaims(token).getSubject();
    }

    // Extract Role from JWT
    public String extractRole(String token) {
        return getClaims(token).get("role", String.class);
    }

    // Validate JWT Token
    public boolean validateToken(String token, String username) {
        try {
            Claims claims = getClaims(token);
            return username.equals(claims.getSubject()) && !isTokenExpired(token);
        } catch (Exception e) {
            return false; // Invalid token
        }
    }

    // Check Token Expiration
    private boolean isTokenExpired(String token) {
        return getClaims(token).getExpiration().before(new Date());
    }

    // Decode JWT Token and Retrieve Claims
    private Claims getClaims(String token) {
        return Jwts.parser()
                .setSigningKey(secretKey)
                .parseClaimsJws(token)
                .getBody();
    }
}