
package com.tradingapplication.TradingApplication.DateTime;

     // adjust package names to match yours
import java.time.ZoneId;
import java.util.Date;

import com.tradingapplication.TradingApplication.Entity.Wallet;

public class WalletDTO {

    private String username;
    private String type;
    private String status;
    private double amount;
    private Date timestamp;   // java.util.Date works with JSTL
    private String razorpayPaymentId;
    public WalletDTO(Wallet wallet) {
        this.username = wallet.getUsername();
        this.type = wallet.getType();
        this.status = wallet.getStatus();
        this.amount = wallet.getAmount();
        // LocalDateTime ➜ Date conversion
        this.timestamp = Date.from(
                wallet.getTimestamp()
                      .atZone(ZoneId.systemDefault())
                      .toInstant());
        this.razorpayPaymentId=wallet.getRazorpayPaymentId();
    }

    /* ---------- getters ---------- */
    public String getUsername()  { return username; }
    public String getType()      { return type; }
    public String getStatus()    { return status; }
    public double getAmount()    { return amount; }
    public Date getTimestamp()   { return timestamp; }
    public String getRazorpayPaymentId() {return razorpayPaymentId; }
}
