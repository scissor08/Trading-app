package com.tradingapplication.TradingApplication.Controller;

import java.io.IOException;
import java.util.Base64;

import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Repository.KycRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Service.KycService;
import com.tradingapplication.TradingApplication.Service.PdfGeneratorService;
import com.tradingapplication.TradingApplication.dto.KycRequestDTO;
import com.tradingapplication.TradingApplication.dto.KycResponseDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/kyc")
@RequiredArgsConstructor
public class KycController {

    // Spring will inject these via constructor
    private final KycService kycService;
    private final KycRepository kycRepository;
    private final UserDetailsRepository userDetailsRepository;
    private final PdfGeneratorService pdfGeneratorService;

    // Show KYC form; check if user already submitted KYC
    @GetMapping("/form")
    public String showKycForm(@RequestParam("username") String username, Model model) {
        UserTable user = userDetailsRepository.findByUsername(username).orElse(null);
        if (user != null && user.getKycEntity() != null) {
            return "kyc_already_submitted";  // Show message if already submitted
        }
        model.addAttribute("username", username);  // Pass username to form
        return "kyc-form";
    }

    // Handle form submission
    @PostMapping("/submit")
    public String submitKyc(
            @RequestParam("username") String username,
            @RequestParam("userFullName") String userFullName,
            @RequestParam("userDob") String userDob,
            @RequestParam("userGender") String userGender,
            @RequestParam("userNationality") String userNationality,
            @RequestParam("userEmail") String userEmail,
            @RequestParam("userMobile") String userMobile,
            @RequestParam("userAddress") String userAddress,
            @RequestParam("userDocType") String userDocType,
            @RequestParam("userDocNumber") String userDocNumber,
            @RequestParam("frontDoc") MultipartFile frontDoc,
            @RequestParam(value = "backDoc", required = false) MultipartFile backDoc,
            @RequestParam("selfie") MultipartFile selfie,
            Model model
    ) throws IOException {

        // Convert files to Base64 strings
        String frontBase64 = encodeToBase64(frontDoc);
        String backBase64 = (backDoc != null && !backDoc.isEmpty()) ? encodeToBase64(backDoc) : null;
        String faceBase64 = encodeToBase64(selfie);

        // Build request DTO for service
        KycRequestDTO request = KycRequestDTO.builder()
                .username(username)
                .userFullName(userFullName)
                .userDob(userDob)
                .userGender(userGender)
                .userNationality(userNationality)
                .userEmail(userEmail)
                .userMobile(userMobile)
                .userAddress(userAddress)
                .userDocType(userDocType)
                .userDocNumber(userDocNumber)
                .documentPrimaryBase64(frontBase64)
                .documentSecondaryBase64(backBase64)
                .faceBase64(faceBase64)
                .build();

        // Call service for verification and saving
        KycResponseDTO response = kycService.verifyAndSave(request);
        model.addAttribute("response", response);

        // Return success or error page based on response
        return (response.isSuccess() && "accept".equalsIgnoreCase(response.getDecision()))
                ? "kyc_success"
                : "kyc_error";
    }

    // Download generated KYC PDF by ID
    @GetMapping("/download/{id}")
    public ResponseEntity<byte[]> downloadKycPdf(@PathVariable Long id) {
        return kycRepository.findById(id)
                .map(entity -> {
                    byte[] pdf = pdfGeneratorService.generateKycPdf(entity);
                    HttpHeaders headers = new HttpHeaders();
                    headers.setContentType(MediaType.APPLICATION_PDF);
                    headers.setContentDisposition(ContentDisposition.attachment()
                            .filename("kyc_record_" + id + ".pdf").build());
                    return new ResponseEntity<>(pdf, headers, HttpStatus.OK);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    // Admin view to list all KYC records
    @GetMapping("/admin")
    public String listAllKycs(Model model) {
        model.addAttribute("records", kycRepository.findAll());
        return "kyc_admin";
    }

    // Utility method to encode MultipartFile to Base64 string
    private String encodeToBase64(MultipartFile file) throws IOException {
        return Base64.getEncoder().encodeToString(file.getBytes());
    }
}
