package com.tradingapplication.TradingApplication.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository; 
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.User;
import com.tradingapplication.TradingApplication.Entity.UserTable;


@Repository
public interface UserRepository extends JpaRepository<UserTable,Integer>{

	
	Optional<User> findByEmail(String email);

}
