package com.tradingapplication.TradingApplication.Entity;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int userId;
	private String username;
	
	@OneToOne(mappedBy="user")
	UserDetails userdetails;
	
	 
    @OneToOne
    UserAccountDetails userAccountDetails;
	
	@OneToMany(mappedBy = "user")
    private List<Portfolio> portfolioEntries;
	
}
