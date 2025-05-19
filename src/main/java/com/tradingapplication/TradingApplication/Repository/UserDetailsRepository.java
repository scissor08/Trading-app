package com.tradingapplication.TradingApplication.Repository;

import java.util.Optional; 

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.UserDetails;
import com.tradingapplication.TradingApplication.Entity.UserLog;


@Repository
public interface UserDetailsRepository extends JpaRepository<UserDetails,Integer>{

	@Query(value = "Select * from User_Details where UserLog.username=?1 and UserLog.password=?2", nativeQuery=true)
	Optional<UserLog> findByUsernameAndPassword(String username,String password);
	
	Optional<UserDetails> findByUsername(String username);
	
	Optional<UserDetails> findByEmail(String email);
}
