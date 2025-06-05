<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>KYC Success</title>
</head>
<body>
    <h2>✅ KYC Verification Successful</h2>

    <p><strong>Decision:</strong> ${response.decision}</p>
    <p><strong>Confidence Score:</strong> ${response.confidence}</p>

    <h3>Extracted Information</h3>
    <ul>
        <li><strong>Full Name:</strong> ${response.extractedData.fullName}</li>
        <li><strong>Date of Birth:</strong> ${response.extractedData.dob}</li>
        <li><strong>Document Number:</strong> ${response.extractedData.documentNumber}</li>
    </ul>

    <p>Your identity has been successfully verified.</p>
    <a href="/kyc/form">Start New KYC</a>
</body>
</html>
