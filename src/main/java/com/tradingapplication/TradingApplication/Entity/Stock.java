package com.tradingapplication.TradingApplication.Entity;

import java.util.List;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Stock {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String symbol;
    private String open;
    private String high;
    private String low;
    private String price;
    private String volume;

    @Column(name = "latest_trading_day")
    private String latestTradingDay;

    @Column(name = "previous_close")
    private String previousClose;

    @Column(name = "change_value")
    private String change;

    @Column(name = "change_percent")
    private String changePercent;

    private String domain;

    

    @OneToMany(mappedBy = "stocks", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Portfolio> portfolioRecords;
    
    
}
