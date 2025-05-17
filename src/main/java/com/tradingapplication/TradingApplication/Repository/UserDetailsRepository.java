package com.tradingapplication.TradingApplication.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.User;
import com.tradingapplication.TradingApplication.Entity.UserDetails;


@Repository
public interface UserDetailsRepository extends JpaRepository<UserDetails,String>{

	@Query(value = "Select * from UserDetails where UserLog.username=?1 and UserLog.password=?2", nativeQuery=true)
	Optional<User> findByUsernameAndPassword(String username,String password);
	
	Optional<UserDetails> findByUserName(String username);
}
