<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Forgot Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 400px;
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }
        .container h2 {
            text-align: center;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        input[type=text], input[type=password] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
        }
        .info-message {
            color: green;
            margin-bottom: 15px;
        }
        .readonly-text {
            padding: 10px;
            background-color: #e9ecef;
            border-radius: 6px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Forgot Password</h2>

    <c:if test="${error != null}">
        <div class="error-message">${error}</div>
    </c:if>

    <c:if test="${info != null}">
        <div class="info-message">${info}</div>
    </c:if>

    <!-- Step 1: Enter Email or Username -->
    <c:if test="${empty otpSent and empty otpVerified}">
        <form method="post" action="/uservalidate">
            <div class="form-group">
                <input type="text" name="emailOrUsername" placeholder="Email or Username"
                       value="${emailOrUsername != null ? emailOrUsername : ''}" required/>
            </div>
            <button type="submit">Send OTP</button>
        </form>
    </c:if>

    <!-- Step 2: Enter OTP -->
    <c:if test="${otpSent}">
        <form method="post" action="/otpvalidate" style="margin-top: 20px;">
            <!-- Freeze and show user -->
            <div class="form-group">
                <label>Email or Username:</label>
                <div class="readonly-text">${emailOrUsername}</div>
            </div>
            <input type="hidden" name="emailOrUsername" value="${emailOrUsername}" />
            <div class="form-group">
                <input type="text" name="otp" placeholder="Enter OTP" required/>
            </div>
            <button type="submit">Verify OTP</button>
        </form>
    </c:if>

    <!-- Step 3: Reset Password -->
    <c:if test="${otpVerified}">
        <form method="post" action="/updatePassword" style="margin-top: 20px;" onsubmit="return validatePassword();">
    <!-- Freeze and show user -->
    <div class="form-group">
        <label>Email or Username:</label>
        <div class="readonly-text">${emailOrUsername}</div>
    </div>
    <input type="hidden" name="emailOrUsername" value="${emailOrUsername}" />

    <!-- New Password Field -->
    <div class="form-group">
        <input 
            type="password" 
            name="password" 
            id="newPassword"
            placeholder="New Password" 
            required 
            pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
            title="Password must be at least 8 characters and include uppercase, lowercase, number, and symbol."
        />
    </div>

    <!-- Confirm Password Field -->
    <div class="form-group">
        <input 
            type="password" 
            name="confirmPassword" 
            id="confirmPassword"
            placeholder="Confirm Password" 
            required
        />
    </div>

    <button type="submit">Reset Password</button>
</form>
    </c:if>
</div>
<script>
function validatePassword() {
    const password = document.getElementById("newPassword").value;
    const confirm = document.getElementById("confirmPassword").value;

    if (password !== confirm) {
        alert("Passwords do not match.");
        return false; // Prevent form submission
    }
    return true;
}
</script>

</body>
</html>
