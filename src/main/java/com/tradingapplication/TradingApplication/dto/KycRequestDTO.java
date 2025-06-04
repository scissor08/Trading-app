package com.tradingapplication.TradingApplication.dto;

import com.tradingapplication.TradingApplication.Entity.KycEntity;
import com.tradingapplication.TradingApplication.Entity.UserTable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KycRequestDTO {

    private String username; // ✅ Added field

    // Base64-encoded files
    private String documentPrimaryBase64;
    private String documentSecondaryBase64;
    private String faceBase64;

    // User-entered form fields
    private String userFullName;
    private String userDob;
    private String userGender;
    private String userNationality;
    private String userEmail;
    private String userMobile;
    private String userAddress;
    private String userDocNumber;
    private String userDocType;

    public KycEntity toEntity(UserTable userTable, String decision, double confidence,
                              String extractedFullName, String extractedDob,
                              String extractedDocNumber, Integer extractedAge,
                              String extractedDocumentType) {
        return KycEntity.builder()
                .userFullName(this.userFullName)
                .userDob(this.userDob)
                .userGender(this.userGender)
                .userNationality(this.userNationality)
                .userEmail(this.userEmail)
                .userMobile(this.userMobile)
                .userAddress(this.userAddress)
                .userDocNumber(this.userDocNumber)
                .userDocType(this.userDocType)
                .extractedFullName(extractedFullName)
                .extractedDob(extractedDob)
                .extractedDocNumber(extractedDocNumber)
                .extractedAge(extractedAge)
                .extractedDocumentType(extractedDocumentType)
                .confidence(confidence)
                .decision(decision)
                .userTable(userTable) // ✅ very important to link the UserTable object
                .build();
    }
}
