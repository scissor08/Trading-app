package com.tradingapplication.TradingApplication.dto;

public class UserResponseDTO {

	private String username;

	public UserResponseDTO() {
		super();
	}

	public UserResponseDTO(String username) {
		super();
		this.username = username;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Override
	public String toString() {
		return "UserResponseDTO [username=" + username + "]";
	}

	
}
