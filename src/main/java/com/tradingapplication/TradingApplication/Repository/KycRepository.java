package com.tradingapplication.TradingApplication.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.KycEntity;

@Repository
public interface KycRepository extends JpaRepository<KycEntity, Long> {
	Optional<KycEntity> findByUserEmail(String userEmail);
	Optional<KycEntity> findById(int i);


	// You can add custom query methods later if needed
}
