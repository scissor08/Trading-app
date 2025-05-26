package com.tradingapplication.TradingApplication.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.GrowthReportEntity;

@Repository
public interface GrowthReportRepository extends JpaRepository<GrowthReportEntity,String>{
	

}
