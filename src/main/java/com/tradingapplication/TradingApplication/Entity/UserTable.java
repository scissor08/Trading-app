package com.tradingapplication.TradingApplication.Entity;

import java.util.Date;  
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
//import jakarta.persistence.Column;
//import jakarta.persistence.Entity;
//import jakarta.persistence.GeneratedValue;
//import jakarta.persistence.GenerationType;
//import jakarta.persistence.Id;
//import jakarta.persistence.JoinColumn;
//import jakarta.persistence.Lob;
//import jakarta.persistence.OneToMany;
//import jakarta.persistence.OneToOne;
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
        @UniqueConstraint(columnNames = "mobile"),
        @UniqueConstraint(columnNames = "pan")
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

    @Column(nullable = false)
    private String mobile;

    @Column(nullable = false)
    private String pan;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateOfBirth;
    
    @OneToOne(cascade=CascadeType.ALL)
    @JoinColumn(name = "user_log_username", referencedColumnName = "username")
    @JsonIgnore
    private UserLog userLog;
    
    @OneToMany
    List<Stock> stocks;
    
    @OneToOne(cascade=CascadeType.ALL)
    UserAccountDetails userAccountDetails;
    
    @OneToMany(mappedBy = "userDetails", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<TransactionBuySell> transaction;

    
    @OneToMany
    private List<Portfolio> portfolio;
    
}
