package com.tradingapplication.TradingApplication.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserLog {

	@Id
	private String username;
	private String password;
	
	@OneToOne(mappedBy="userLog")
	UserDetails userDetails;
	
}
