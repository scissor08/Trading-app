package com.tradingapplication.TradingApplication.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.UserTable;


@Repository
public interface UserDetailsRepository extends JpaRepository<UserTable,Integer>{
	
    boolean existsByUsername(@Param("username") String username);
    boolean existsByEmail(@Param("email") String email);
	
	Optional<UserTable> findByUsername(String username);
	Optional<UserTable> findByEmail(String emailOrUsername);
	
	
}
