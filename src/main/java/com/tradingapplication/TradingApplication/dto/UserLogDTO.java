package com.tradingapplication.TradingApplication.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserLogDTO {

	private String username;
	private String password;
	private String captcha;
}
