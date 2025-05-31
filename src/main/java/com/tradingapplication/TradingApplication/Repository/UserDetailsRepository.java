package com.tradingapplication.TradingApplication.Repository;

import java.util.Optional;   

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.UserLog;
import com.tradingapplication.TradingApplication.Entity.UserTable;


@Repository
public interface UserDetailsRepository extends JpaRepository<UserTable,Integer>{

	@Query(value = "Select * from User_Details where UserLog.username=?1 and UserLog.password=?2", nativeQuery=true)
	Optional<UserLog> findByUsernameAndPassword(String username,String password);
	
	@Query(value = "SELECT COUNT(*) > 0 FROM users WHERE username = :username", nativeQuery = true)
    boolean existsByUsername(@Param("username") String username);
	@Query(value = "SELECT COUNT(*) > 0 FROM users WHERE email = :email", nativeQuery = true)
    boolean existsByEmail(@Param("email") String email);
	@Query(value = "SELECT COUNT(*) > 0 FROM users WHERE mobile = :mobile", nativeQuery = true)
    boolean existsByMobile(@Param("mobile") String mobile);
	@Query(value = "SELECT COUNT(*) > 0 FROM users WHERE pan = :pan", nativeQuery = true)
    boolean existsByPan(@Param("pan") String pan);
	
	Optional<UserTable> findByUsername(String username);
	Optional<UserTable> findByEmail(String emailOrUsername);
	
	
}
