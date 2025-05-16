package com.tradingapplication.TradingApplication.Repository;

import com.tradingapplication.TradingApplication.Entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UserEntity,Integer> {

}
