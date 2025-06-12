package com.tradingapplication.TradingApplication.Service;

import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.dto.UserRequestDTO;

import jakarta.servlet.http.HttpSession; 


public interface UserServiceInterface {

	public String addNewUser(UserRequestDTO requestDto);
	public boolean sendOtp(UserRequestDTO requestDto,HttpSession session);
//	public String getEditPage(HttpSession session, Model model);
//	String updateData(UpdateRequestDTO requestDto, HttpSession session, Model model);
	String validation(UserRequestDTO requestDto, Model model);
	boolean sendOtpToUser(String emailOrUsername, Model model, HttpSession session);
	public String updatePassword(String password, String emailOrUsername);
	public boolean verifyCaptcha(String captchaResponse);
//	String userLogin(UserLogDTO userlog, Model model, HttpSession session);
}
