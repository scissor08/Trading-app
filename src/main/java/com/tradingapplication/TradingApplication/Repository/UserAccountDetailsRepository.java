package com.tradingapplication.TradingApplication.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.UserAccountDetails;

@Repository
public interface UserAccountDetailsRepository extends JpaRepository<UserAccountDetails,Integer>{
	

}
