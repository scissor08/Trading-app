package com.tradingapplication.TradingApplication.Entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

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
public class UserDetails {

	@Id
	private String email;
	private String mobile;
	private String pan;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dateOfBirth;
    
    @OneToOne
    User user;
    
    @OneToOne
    UserLog userLog;
   
    
}
