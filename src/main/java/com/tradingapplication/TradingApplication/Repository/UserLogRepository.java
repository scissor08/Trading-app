package com.tradingapplication.TradingApplication.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.UserLog;

@Repository
public interface UserLogRepository extends JpaRepository<UserLog,String>{
	

	@Query(value = "SELECT COUNT(*) > 0 FROM users WHERE username = :username", nativeQuery = true)
    boolean existsByUsername(@Param("username") String username);
	
	UserLog findByUsername(String username);
	
}
