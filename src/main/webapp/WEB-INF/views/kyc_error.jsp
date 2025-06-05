<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>KYC Verification Failed</title>
</head>
<body>
    <h2>❌ KYC Verification Failed</h2>

    <p><strong>Reason:</strong> ${response.message}</p>
    <p><strong>Confidence Score:</strong> ${response.confidence}</p>

    <c:if test="${not empty response.extractedData}">
        <h3>Extracted Information (for review)</h3>
        <ul>
            <li><strong>Full Name:</strong> ${response.extractedData.fullName}</li>
            <li><strong>Date of Birth:</strong> ${response.extractedData.dob}</li>
            <li><strong>Document Number:</strong> ${response.extractedData.documentNumber}</li>
        </ul>
    </c:if>

    <p>Please ensure your documents are valid and try again.</p>
    <a href="/kyc/form">Go Back to KYC Form</a>
</body>
</html>
