package com.tradingapplication.TradingApplication.Service;

import org.springframework.ui.Model;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.dto.UpdateRequestDTO;
import com.tradingapplication.TradingApplication.dto.UserRequestDTO;

import jakarta.servlet.http.HttpSession; 


public interface UserServiceInterface {

	public String addNewUser(UserRequestDTO requestDto);
	String userLogin(UserLog userlog, Model model);
	public String sendOtp(UserRequestDTO requestDto,HttpSession session);
	public String getEditPage(HttpSession session, Model model);
	String updateData(UpdateRequestDTO requestDto, HttpSession session, Model model);
}
