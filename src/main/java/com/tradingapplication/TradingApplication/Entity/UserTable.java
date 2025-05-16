package com.tradingapplication.TradingApplication.Entity;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.CascadeType;
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
public class UserTable {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int Id;
	private String username;
	private String email;
	private String mobile;
	private String pan;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dateOfBirth;
//	private double walletBalance;

    @OneToOne(mappedBy = "UserTable", cascade = CascadeType.ALL)
    private Account account;


    @OneToMany(mappedBy = "UserTable", cascade = CascadeType.ALL)
    private List<StockEntity> stockEntity;
}


	
	


