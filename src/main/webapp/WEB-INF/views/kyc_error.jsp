<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>KYC Verification Failed</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 20px;
            color: #333;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            padding: 30px;
            text-align: center;
        }

        h2 {
            font-size: 28px;
            font-weight: 300;
            margin-bottom: 10px;
        }

        .content {
            padding: 30px;
        }

        p {
            margin-bottom: 15px;
            line-height: 1.6;
        }

        strong {
            color: #2c3e50;
            font-weight: 600;
        }

        .reason {
            background: #fff5f5;
            border-left: 4px solid #e74c3c;
            padding: 15px;
            margin: 20px 0;
            border-radius: 0 5px 5px 0;
        }

        .confidence {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
            border: 1px solid #dee2e6;
        }

        h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 20px;
            font-weight: 500;
        }

        ul {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            border: 1px solid #dee2e6;
        }

        li {
            margin-bottom: 10px;
            padding-left: 10px;
            border-left: 3px solid #3498db;
            list-style: none;
        }

        .actions {
            margin-top: 30px;
            text-align: center;
        }

        a {
            display: inline-block;
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }

        a:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
        }

        .footer-text {
            text-align: center;
            color: #7f8c8d;
            font-size: 14px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #ecf0f1;
        }

        @media (max-width: 768px) {
            body {
                padding: 10px;
            }
            
            .container {
                margin: 0;
            }
            
            .header {
                padding: 20px;
            }
            
            .content {
                padding: 20px;
            }
            
            h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>❌ KYC Verification Failed</h2>
        </div>
        
        <div class="content">
            <div class="reason">
                <p><strong>Reason:</strong> ${response.message}</p>
            </div>
            
            <div class="confidence">
                <p><strong>Confidence Score:</strong> ${response.confidence}</p>
            </div>

            <c:if test="${not empty response.extractedData}">
                <h3>Extracted Information (for review)</h3>
                <ul>
                    <li><strong>Full Name:</strong> ${response.extractedData.fullName}</li>
                    <li><strong>Date of Birth:</strong> ${response.extractedData.dob}</li>
                    <li><strong>Document Number:</strong> ${response.extractedData.documentNumber}</li>
                </ul>
            </c:if>

            <div class="footer-text">
                <p>Please ensure your documents are valid and try again.</p>
            </div>
            
            <div class="actions">
                <a href="/kyc/form">Go Back to KYC Form</a>
            </div>
        </div>
    </div>
</body>
</html>