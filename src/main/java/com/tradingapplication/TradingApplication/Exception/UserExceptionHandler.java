package com.tradingapplication.TradingApplication.Exception;

import org.springframework.http.HttpStatus; 
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class UserExceptionHandler {

    @ExceptionHandler(DataNotFoundException.class)
    public ResponseEntity<?> dataNotFoundException(String message){
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Data Not Found . . . ");
    }
}
