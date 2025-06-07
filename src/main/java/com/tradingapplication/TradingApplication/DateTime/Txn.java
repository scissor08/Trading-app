package com.tradingapplication.TradingApplication.DateTime;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class Txn {
    private LocalDateTime timestamp;

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public Date getFormattedTimestamp() {
        // Convert LocalDateTime to java.util.Date
        return Date.from(timestamp.atZone(ZoneId.systemDefault()).toInstant());
    }
}
