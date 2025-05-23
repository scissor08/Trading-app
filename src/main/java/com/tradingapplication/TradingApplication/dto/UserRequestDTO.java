package com.tradingapplication.TradingApplication.dto;

import java.util.Date; 

import org.springframework.format.annotation.DateTimeFormat;

public class UserRequestDTO {

	private String name;
	private String username;
	private String password;
	private String cpass;
	private String email;
	private String mobile;
	private String pan;
	
    @DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dateOfBirth;
	
	
	public UserRequestDTO() {
		
	}
	
	public UserRequestDTO(String username, String password, String cpass, String email, String mobile, String pan,
			Date dateOfBirth) {
		
		this.username = username;
		this.password = password;
		this.cpass = cpass;
		this.email = email;
		this.mobile = mobile;
		this.pan = pan;
		this.dateOfBirth = dateOfBirth;
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
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPan() {
		return pan;
	}
	public void setPan(String pan) {
		this.pan = pan;
	}
	public Date getDateOfBirth() {
		return dateOfBirth;
	}
	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
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
				+ ", email=" + email + ", mobile=" + mobile + ", pan=" + pan + ", dateOfBirth=" + dateOfBirth + "]";
	}
	
	
	
}
