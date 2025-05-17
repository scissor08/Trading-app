package com.tradingapplication.TradingApplication.Repository;


import org.springframework.data.jpa.repository.JpaRepository; 
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.User;


@Repository
public interface UserRepository extends JpaRepository<User,Integer>{

	

}
