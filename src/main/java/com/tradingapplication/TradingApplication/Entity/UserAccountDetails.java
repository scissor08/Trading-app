package com.tradingapplication.TradingApplication.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UserAccountDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int walletId;
	private double balance;
	
	
	@OneToOne(mappedBy="userAccountDetails")
	@ToString.Exclude
	UserTable userdetails;
	
}
