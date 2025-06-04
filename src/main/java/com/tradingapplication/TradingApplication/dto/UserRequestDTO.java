package com.tradingapplication.TradingApplication.dto;

public class UserRequestDTO {

	private String name;
	private String username;
	private String password;
	private String cpass;
	private String email;
	
	
	public UserRequestDTO() {
		
	}
	
	public UserRequestDTO(String username, String password, String cpass, String email) {
		
		this.username = username;
		this.password = password;
		this.cpass = cpass;
		this.email = email;
	}

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	
	public String getCpass() {
		return cpass;
	}
	public void setCpass(String cpass) {
		this.cpass = cpass;
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "UserRequestDTO [name=" + name + ", username=" + username + ", password=" + password + ", cpass=" + cpass
				+ ", email=" + email + "]";
	}
	
	
	
}
