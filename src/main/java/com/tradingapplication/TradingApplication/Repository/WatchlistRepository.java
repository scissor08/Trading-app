package com.tradingapplication.TradingApplication.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.tradingapplication.TradingApplication.Entity.Watchlist;

import java.util.List;
import java.util.Optional;

public interface WatchlistRepository extends JpaRepository<Watchlist, Integer> {
    Optional<Watchlist> findBySymbol(String symbol);
    
    @Query(value = "SELECT * FROM Watchlist WHERE user_Id = :id", nativeQuery = true)
    List<Watchlist> findAllByUserId(@Param("id") int id);

    

	@Query(value = "SELECT * FROM watchlist w WHERE w.user_id = :userId AND w.symbol = :symbol", nativeQuery = true)
	Optional<Watchlist> findByUserIdAndSymbol(@Param("userId") int userId, @Param("symbol") String symbol);

}
    


