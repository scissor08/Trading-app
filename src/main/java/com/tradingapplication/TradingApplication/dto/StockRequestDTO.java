package com.tradingapplication.TradingApplication.dto;

import lombok.Data;

@Data
public class StockRequestDTO {

    private String symbol;
    private String price;
    private String open;
    private String high;
    private String low;
    private String previousClose;
    private String change;
    private String changePercent;
    private String latestTradingDay;
    private String domain;
}
