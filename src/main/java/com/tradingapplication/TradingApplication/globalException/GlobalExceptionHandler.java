package com.tradingapplication.TradingApplication.globalException;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import io.jsonwebtoken.ExpiredJwtException;
import jakarta.servlet.http.HttpServletResponse;

@ControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(DataNotFoundException.class)
	public ResponseEntity<?> dataNotFound(DataNotFoundException e) {
		return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
	}

	@ExceptionHandler(BadRequest.class)
	public ResponseEntity<?> badrequest(BadRequest e) {
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
	}
	 @ExceptionHandler(ExpiredJwtException.class)
	    public String handleExpiredJwtException(ExpiredJwtException ex, HttpServletResponse response) {
	        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	        return "/arise/login";
	    }

}
