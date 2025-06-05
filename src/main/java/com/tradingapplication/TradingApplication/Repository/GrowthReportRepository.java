package com.tradingapplication.TradingApplication.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.tradingapplication.TradingApplication.Entity.GrowthReportEntity;

@Repository
public interface GrowthReportRepository extends JpaRepository<GrowthReportEntity,String>{

	@Query(value="select * from Transaction_Buy_Sell where user_Id = ?1 ", nativeQuery =  true )
	List<GrowthReportEntity> findAllByUserId(int userId);
}
