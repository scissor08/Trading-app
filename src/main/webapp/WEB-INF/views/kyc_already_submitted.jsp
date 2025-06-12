<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>KYC Already Verified</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        body { font-family: Arial, sans-serif; background-color: #f5f5f5; text-align: center; padding: 50px; }
        .info-box {
            background: white; padding: 30px; border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 255, 0.1); display: inline-block;
        }
        h2 { color: #00529B; }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
    <div class="info-box">
        <h2>ℹ️ You Are Already KYC Verified</h2>
        <p>No need to submit your documents again.</p>
        <p><strong>Verified Full Name:</strong> ${extractedData.fullName}</p>
        <p><strong>DOB:</strong> ${extractedData.dob}</p>
        <p><strong>Document Number:</strong> ${extractedData.documentNumber}</p>
        <br>
        <a href="/dashboard">Proceed to Dashboard</a>
    </div>
</body>
</html>
