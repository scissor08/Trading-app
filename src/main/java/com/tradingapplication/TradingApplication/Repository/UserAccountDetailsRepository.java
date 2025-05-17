package com.tradingapplication.TradingApplication.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;

public interface UserAccountDetailsRepository extends JpaRepository<UserAccountDetails,Integer>{
	

}
