<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>KYC Already Verified</title>
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
