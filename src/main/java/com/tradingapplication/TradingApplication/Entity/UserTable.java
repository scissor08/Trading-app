package com.tradingapplication.TradingApplication.Entity;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(
    name = "users",
    uniqueConstraints = {
        @UniqueConstraint(columnNames = "username"),
        @UniqueConstraint(columnNames = "email"),
    }
)
public class UserTable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userId;

    private String name;

    @Lob
    private byte[] profileImage;

    @Column(nullable = false)
    private String username;

    @Column(nullable = false)
    private String email;

    @OneToOne(cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    @JoinColumn(name = "user_log_username", referencedColumnName = "username")
    @JsonIgnore
    private UserLog userLog;
    
    @OneToMany
    List<Stock> stocks;
    
    @OneToOne(cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    UserAccountDetails userAccountDetails;
    
    @OneToOne(mappedBy = "userTable", cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    private KycEntity kycEntity;


    @OneToMany(mappedBy="user" ,cascade = CascadeType.ALL)
    private List<Watchlist> watchlist;
    
    @OneToMany(mappedBy = "userDetails", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<TransactionBuySell> transaction;

    
    @OneToMany
    private List<Portfolio> portfolio;
    
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Wallet> walletTransactions;



    @OneToMany(mappedBy = "userTable",fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<GrowthReportEntity> growthReport;

	@Override
	public String toString() {
		return "UserTable [userId=" + userId + ", name=" + name + ", username=" + username + ", email=" + email
				+ ", userLog=" + userLog + ", stocks=" + stocks + ", userAccountDetails=" + userAccountDetails
				+ ", kycEntity=" + kycEntity + ", transaction=" + transaction + ", portfolio=" + portfolio
				+ ", growthReport=" + growthReport + "]";
	}

	
    
    
}
