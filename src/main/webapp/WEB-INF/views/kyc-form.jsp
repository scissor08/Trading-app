<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KYC Verification Form</title>
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
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: #ffffff;
            color: #333333;
            line-height: 1.6;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #ffffff;
            border: 1px solid #e1e5e9;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #bbf7d0 0%, #bfdbfe 100%);
            color: #1e293b;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .header p {
            font-size: 16px;
            opacity: 0.9;
        }

        .form-content {
            padding: 40px;
        }

        .form-section {
            margin-bottom: 32px;
        }

        .section-title {
            font-size: 20px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f8f9fa;
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            flex: 1;
        }

        .form-group.full-width {
            flex: 100%;
        }

        label {
            display: block;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 14px;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="date"],
        select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #ffffff;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="tel"]:focus,
        input[type="date"]:focus,
        select:focus {
            outline: none;
            border-color: #86efac;
            box-shadow: 0 0 0 3px rgba(134, 239, 172, 0.3);
        }

        input[type="file"] {
            width: 100%;
            padding: 12px;
            border: 2px dashed #e1e5e9;
            border-radius: 6px;
            background-color: #f8f9fa;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        input[type="file"]:hover {
            border-color: #93c5fd;
            background-color: #eff6ff;
        }

        select {
            cursor: pointer;
        }

        .required {
            color: #e74c3c;
        }

        .submit-section {
            margin-top: 40px;
            padding-top: 30px;
            border-top: 1px solid #e1e5e9;
            text-align: center;
        }

        .submit-btn {
            background: linear-gradient(135deg, #bbf7d0 0%, #bfdbfe 100%);
            color: #1e293b;
            padding: 14px 32px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            min-width: 200px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(134, 239, 172, 0.4);
        }

        .file-info {
            font-size: 12px;
            color: #6c757d;
            margin-top: 4px;
        }

        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .form-content {
                padding: 24px;
            }
            
            .header {
                padding: 24px;
            }
            
            .header h1 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
    <div class="container">
        <div class="header">
            <h1>KYC Verification</h1>
            <p>Please provide the following information for identity verification</p>
        </div>

        <div class="form-content">
            <form action="/kyc/submit" method="post" enctype="multipart/form-data">
            <input type="hidden" name="username" value="${username}" />
            
                
                <!-- Personal Information Section -->
                <div class="form-section">
                    <h2 class="section-title">Personal Information</h2>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="userFullName">Full Name <span class="required">*</span></label>
                            <input type="text" id="userFullName" name="userFullName" required />
                        </div>
                        <div class="form-group">
                            <label for="userDob">Date of Birth <span class="required">*</span></label>
                            <input type="date" id="userDob" name="userDob" required />
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="userGender">Gender <span class="required">*</span></label>
                            <select id="userGender" name="userGender" required>
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="userNationality">Nationality <span class="required">*</span></label>
                            <input type="text" id="userNationality" name="userNationality" value="India" required />
                        </div>
                    </div>
                </div>

                <!-- Contact Information Section -->
                <div class="form-section">
                    <h2 class="section-title">Contact Information</h2>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="userEmail">Email Address <span class="required">*</span></label>
                            <input type="email" id="userEmail" name="userEmail" required />
                        </div>
                        <div class="form-group">
                            <label for="userMobile">Mobile Number <span class="required">*</span></label>
                            <input type="tel" id="userMobile" name="userMobile" required />
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <label for="userAddress">Complete Address <span class="required">*</span></label>
                        <input type="text" id="userAddress" name="userAddress" required />
                    </div>
                </div>

                <!-- Document Verification Section -->
                <div class="form-section">
                    <h2 class="section-title">Document Verification</h2>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="userDocType">Document Type <span class="required">*</span></label>
                            <select id="userDocType" name="userDocType" required>
                                <option value="">Select Document Type</option>
                                <option value="pan">PAN Card</option>
                                <option value="passport">Passport</option>
                                <option value="license">Driving License</option>
                                <option value="aadhaar">Aadhaar Card</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="userDocNumber">Document Number <span class="required">*</span></label>
                            <input type="text" id="userDocNumber" name="userDocNumber" required />
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="frontDoc">Document Front Side <span class="required">*</span></label>
                            <input type="file" id="frontDoc" name="frontDoc" accept="image/*" required />
                            <div class="file-info">Upload clear image of document front (JPEG, PNG, max 5MB)</div>
                        </div>
                        <div class="form-group">
                            <label for="backDoc">Document Back Side</label>
                            <input type="file" id="backDoc" name="backDoc" accept="image/*" />
                            <div class="file-info">Upload if applicable (JPEG, PNG, max 5MB)</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="selfie">Selfie Photo <span class="required">*</span></label>
                        <input type="file" id="selfie" name="selfie" accept="image/*" capture="user" required />
                        <div class="file-info">Upload a clear selfie for identity verification (JPEG, PNG, max 5MB)</div>
                    </div>
                </div>

                <div class="submit-section">
                    <button type="submit" class="submit-btn">Submit for Verification</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>