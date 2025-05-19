package com.tradingapplication.TradingApplication.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Entity
@Getter
@Setter
public class Stock {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String symbol;
    private String price;
    private String change;
    private String changePercent;
    private String high;
    private String low;
    private String open;
    private String previousClose;
    private String latestTradingDay;
    private String domain;

    @Temporal(TemporalType.TIMESTAMP)
    private Date lastUpdated; // ✅ Timestamp for caching
}
