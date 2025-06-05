<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>KYC Success</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #e3f2fd 0%, #f1f8e9 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .success-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 25px 50px rgba(79, 195, 247, 0.15);
            max-width: 500px;
            width: 100%;
            text-align: center;
            overflow: hidden;
            position: relative;
        }

        .success-header {
            background: linear-gradient(135deg, #81c784, #4fc3f7);
            padding: 40px 30px;
            position: relative;
            overflow: hidden;
        }

        .success-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 20px 20px;
            animation: float 20s linear infinite;
        }

        @keyframes float {
            0% { transform: translate(-50px, -50px); }
            100% { transform: translate(50px, 50px); }
        }

        .success-icon {
            width: 80px;
            height: 80px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 36px;
            color: #4fc3f7;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 1;
            animation: checkmark 0.8s ease-in-out;
        }

        @keyframes checkmark {
            0% {
                transform: scale(0) rotate(45deg);
                opacity: 0;
            }
            50% {
                transform: scale(1.2) rotate(45deg);
                opacity: 1;
            }
            100% {
                transform: scale(1) rotate(0deg);
                opacity: 1;
            }
        }

        .success-title {
            color: white;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
            position: relative;
            z-index: 1;
        }

        .success-subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 16px;
            position: relative;
            z-index: 1;
        }

        .success-content {
            padding: 30px;
        }

        .verification-details {
            background: #f8fffe;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            border: 1px solid #e6f7f4;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            padding: 8px 0;
        }

        .detail-row:last-child {
            margin-bottom: 0;
        }

        .detail-label {
            font-weight: 500;
            color: #2d3748;
            font-size: 14px;
        }

        .detail-value {
            font-weight: 600;
            color: #1a202c;
            font-size: 14px;
        }

        .confidence-score {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .confidence-bar {
            width: 60px;
            height: 6px;
            background: #e2e8f0;
            border-radius: 3px;
            overflow: hidden;
        }

        .confidence-fill {
            height: 100%;
            background: linear-gradient(90deg, #81c784, #4fc3f7);
            border-radius: 3px;
            animation: fillConfidence 1.5s ease-out;
        }

        @keyframes fillConfidence {
            from { width: 0%; }
        }

        .extracted-info {
            background: #f7fafc;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            text-align: left;
        }

        .info-title {
            font-size: 16px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 15px;
            text-align: center;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #e2e8f0;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 500;
            color: #4a5568;
            font-size: 14px;
        }

        .info-value {
            font-weight: 600;
            color: #1a202c;
            font-size: 14px;
            font-family: 'SF Mono', Monaco, monospace;
            background: white;
            padding: 4px 8px;
            border-radius: 6px;
            border: 1px solid #e2e8f0;
        }

        .success-message {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            border: 1px solid #b6d7a8;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 25px;
            color: #155724;
            font-weight: 500;
        }

        .dashboard-btn {
            background: linear-gradient(135deg, #81c784, #4fc3f7);
            color: white;
            padding: 16px 40px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(79, 195, 247, 0.3);
            position: relative;
            overflow: hidden;
        }

        .dashboard-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .dashboard-btn:hover::before {
            left: 100%;
        }

        .dashboard-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(79, 195, 247, 0.4);
        }

        .footer-note {
            margin-top: 20px;
            font-size: 12px;
            color: #718096;
            line-height: 1.4;
        }

        @media (max-width: 768px) {
            body {
                padding: 10px;
            }
            
            .success-container {
                margin: 0;
            }
            
            .success-header {
                padding: 30px 20px;
            }
            
            .success-content {
                padding: 20px;
            }
            
            .success-title {
                font-size: 24px;
            }
            
            .dashboard-btn {
                width: 100%;
                padding: 18px;
            }
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(79, 195, 247, 0.7);
            }
            70% {
                box-shadow: 0 0 0 10px rgba(79, 195, 247, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(79, 195, 247, 0);
            }
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
    <div class="success-container">
        <div class="success-header">
            <div class="success-icon pulse">
                ✅
            </div>
            <h2 class="success-title">KYC Verification Successful</h2>
            <p class="success-subtitle">Your identity has been verified successfully</p>
        </div>
        
        <div class="success-content">
            <div class="verification-details">
                <div class="detail-row">
                    <span class="detail-label">Decision:</span>
                    <span class="detail-value">${response.decision}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Confidence Score:</span>
                    <div class="confidence-score">
                        <div class="confidence-bar">
                            <div class="confidence-fill" style="width: ${response.confidence}%"></div>
                        </div>
                        <span class="detail-value">${response.confidence}%</span>
                    </div>
                </div>
            </div>

            <div class="extracted-info">
                <h3 class="info-title">Verified Information</h3>
                <div class="info-item">
                    <span class="info-label">Full Name:</span>
                    <span class="info-value">${response.extractedData.fullName}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Date of Birth:</span>
                    <span class="info-value">${response.extractedData.dob}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Document Number:</span>
                    <span class="info-value">${response.extractedData.documentNumber}</span>
                </div>
            </div>

            <div class="success-message">
                🎉 Congratulations! Your KYC verification is complete. You can now access all features of your account.
            </div>

            <a href="/dashboard" class="dashboard-btn">
                Go to Dashboard
            </a>

            <p class="footer-note">
                Your verified information is securely stored and encrypted.<br>
                You can update your details anytime from your profile settings.
            </p>
        </div>
    </div>

    <script>
        // Animate confidence bar on page load
        document.addEventListener('DOMContentLoaded', function() {
            const confidenceFill = document.querySelector('.confidence-fill');
            if (confidenceFill) {
                const confidence = ${response.confidence != null ? response.confidence : 100};
                setTimeout(() => {
                    confidenceFill.style.width = confidence + '%';
                }, 800);
            }
        });
    </script>
</body>
</html>