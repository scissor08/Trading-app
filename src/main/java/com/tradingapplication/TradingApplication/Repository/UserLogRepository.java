package com.tradingapplication.TradingApplication.Repository;

import org.springframework.data.jpa.repository.JpaRepository; 
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.UserLogin;


@Repository
public interface UserLogRepository extends JpaRepository<UserLogin,String>{

}
