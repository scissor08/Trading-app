package com.tradingapplication.TradingApplication.Entity;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
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

<<<<<<< HEAD
    @OneToMany(mappedBy = "UserTable", cascade = CascadeType.ALL)
    private List<StockEntity> stockEntity;
}
=======

	public UserTable(int id, String username, String email,String mobile, String pan, Date dateOfBirth, double walletBalance) {
		Id = id;
		this.username = username;
		this.email = email;
		this.mobile = mobile;
		this.pan = pan;
		this.dateOfBirth = dateOfBirth;
		this.walletBalance = walletBalance;
	}


	public int getId() {
		return Id;
	}


	public void setId(int id) {
		Id = id;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
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


	public double getWalletBalance() {
		return walletBalance;
	}


	public void setWalletBalance(double walletBalance) {
		this.walletBalance = walletBalance;
	}


	@Override
	public String toString() {
		return "User [Id=" + Id + ", username=" + username + ", email=" + email + ", mobile=" + mobile + ", pan=" + pan
				+ ", dateOfBirth=" + dateOfBirth + ", walletBalance=" + walletBalance + "]";
	}

	
	
	
	
}
>>>>>>> 6452fcf616cd8c5b80223be5e4de2b94e81af5a3
