package com.tradingapplication.TradingApplication.Entity;


import java.time.LocalDateTime; 

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "kyc_records")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KycEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    // ✅ User-entered data
    private String userFullName;
    private String userDob;
    private String userGender;
    private String userNationality;
    private String userEmail;
    private String userMobile;
    private String userAddress;
    private String userDocNumber;
    private String userDocType;

    // ✅ Extracted data
    private String extractedFullName;
    private String extractedDob;
    private String extractedDocNumber;
    private Integer extractedAge;
    private String extractedDocumentType;

    // ✅ Verification outcome
    private Double confidence;
    private String decision; // accept / reject

  

    private LocalDateTime createdAt;
    
    @OneToOne
    @MapsId // This tells JPA to use the same ID as the UserTableAdd commentMore actions
    @JoinColumn(name = "user_id") // FK and PK are same
    private UserTable userTable;
    
    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }
}
