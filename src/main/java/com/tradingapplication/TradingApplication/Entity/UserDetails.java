package com.tradingapplication.TradingApplication.Entity;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDetails {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int userId;
	private String username;
	private String email;
	private String mobile;
	private String pan;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dateOfBirth;
    
    
    @OneToOne(cascade=CascadeType.ALL)
    @JoinColumn(name = "user_log_username", referencedColumnName = "username")
    @JsonIgnore
    private UserLog userLog;
    
    @OneToMany
    List<Stock> stocks;
    
    @OneToOne(cascade=CascadeType.ALL)
    UserAccountDetails userAccountDetails;
   
    
}
