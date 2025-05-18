package com.tradingapplication.TradingApplication.Entity;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@AllArgsConstructor
public class UserLog {

	@Id
	private String username;
	private String password;
	
	@OneToOne(mappedBy="userLog")
	@JsonIgnore
	UserDetails userDetails;
	
	@OneToOne
	UserAccountDetails userAccountDetails;

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
	
	
}
