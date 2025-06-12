package com.tradingapplication.TradingApplication.Service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tradingapplication.TradingApplication.Entity.KycEntity;
import com.tradingapplication.TradingApplication.Entity.UserTable;
import com.tradingapplication.TradingApplication.Repository.KycRepository;
import com.tradingapplication.TradingApplication.Repository.UserDetailsRepository;
import com.tradingapplication.TradingApplication.Repository.UserLogRepository;
import com.tradingapplication.TradingApplication.dto.KycRequestDTO;
import com.tradingapplication.TradingApplication.dto.KycResponseDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class KycService {

	@Autowired
    private final KycRepository kycRepository;
	@Autowired
    private final UserDetailsRepository userDetailsRepository;
	@Autowired
    private final UserLogRepository userLogRepository;
	@Autowired
    private final ObjectMapper objectMapper = new ObjectMapper();

	  @Value("${idanalyzer.apikey}")
	    private String apiKey;
	  
    private final String profileId = "default";
    private static final double CONFIDENCE_THRESHOLD = 0.90;
    private static final String API_URL = "https://api2.idanalyzer.com/scan";

    public KycResponseDTO verifyAndSave(KycRequestDTO request) {
        try {
            log.info("Starting KYC verification for username: {}", request.getUsername());

            // Check if username exists in UserLog
            boolean exists = userLogRepository.existsByUsername(request.getUsername());
            if (!exists) {
                return new KycResponseDTO(false, "reject", 0,
                    "User with username '" + request.getUsername() + "' does not exist.", null);
            }

            // Fetch UserTable by username
            UserTable user = userDetailsRepository.findByUsername(request.getUsername())
                    .orElseThrow(() -> new RuntimeException("UserTable not found for username: " + request.getUsername()));

            // Build payload for IdAnalyzer
            Map<String, Object> payload = new HashMap<>();
            payload.put("profile", profileId);
            payload.put("document", request.getDocumentPrimaryBase64());
            if (request.getDocumentSecondaryBase64() != null) {
                payload.put("document_secondary", request.getDocumentSecondaryBase64());
            }
            payload.put("face", request.getFaceBase64());

            // Call IdAnalyzer API
            RestTemplate restTemplate = new RestTemplate();
            var headers = new org.springframework.http.HttpHeaders();
            headers.set("X-API-KEY", apiKey);
            headers.set("Content-Type", "application/json");

            var httpEntity = new org.springframework.http.HttpEntity<>(payload, headers);
            var response = restTemplate.postForEntity(API_URL, httpEntity, String.class);

            String body = response.getBody();
            JsonNode root = objectMapper.readTree(body);

            if (!root.path("success").asBoolean(false)) {
                String message = root.path("error").path("message").asText();
                return new KycResponseDTO(false, "reject", 0, "Verification failed: " + message, null);
            }

            JsonNode data = root.path("data");

            String extractedFullName = safeGet(data, "fullName");
            String extractedDob = safeGet(data, "dob");
            String extractedDocNumber = safeGet(data, "documentNumber");
            String extractedDocumentType = safeGet(data, "documentType");
            int extractedAge = data.path("age").get(0).path("value").asInt();
            double confidence = data.path("age").get(0).path("confidence").asDouble(0);

            // Matching logic
            boolean nameMatch = normalize(extractedFullName).equals(normalize(request.getUserFullName()));
            boolean dobMatch = extractedDob.equals(request.getUserDob());
            String decision = (confidence >= CONFIDENCE_THRESHOLD && nameMatch && dobMatch) ? "accept" : "reject";

            // Create KycEntity and link UserTable
            KycEntity entity = request.toEntity(user, decision, confidence,
                    extractedFullName, extractedDob, extractedDocNumber, extractedAge, extractedDocumentType);

            entity.setUserTable(user); // crucial to avoid null one-to-one id error
            if(decision.equals("accept")) {
            kycRepository.save(entity);}

            Map<String, Object> preview = new HashMap<>();
            preview.put("fullName", extractedFullName);
            preview.put("dob", extractedDob);
            preview.put("documentNumber", extractedDocNumber);
            

            return new KycResponseDTO(true, decision, confidence,
                    decision.equals("accept") ? "Verification successful" : "Verification failed: mismatch",
                    preview);

        } catch (Exception e) {
            log.error("KYC verification error", e);
            return new KycResponseDTO(false, "reject", 0, "Internal error: " + e.getMessage(), null);
        }
    }

    private String safeGet(JsonNode data, String field) {
        JsonNode node = data.path(field);
        if (node.isArray() && node.size() > 0) {
            return node.get(0).path("value").asText("");
        }
        return "";
    }

    private String normalize(String input) {
        return input == null ? "" : input.trim().toLowerCase().replaceAll("\\s+", "");
    }
}
