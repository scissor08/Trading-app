package com.tradingapplication.TradingApplication.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserAccountDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int walletId;
	private double balance;
	
	
	@OneToOne
	@JoinColumn(name = "user_id")
	private UserTable user;
	
}
