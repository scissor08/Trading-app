<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 30px;
            background-color: #f2f2f2;
        }
        .container {
            background: white;
            max-width: 400px;
            margin: auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #ccc;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        input[type="submit"] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Forgot Password</h2>
    
    <!-- Step 1: Enter Username -->
    <form id="usernameForm" method="post" action="send-otp">
        <label for="username">Enter your username:</label>
        <input type="text" name="username" id="username" required>
        <input type="submit" value="Send OTP">
    </form>

    <!-- Step 2: Enter OTP -->
    <form id="otpForm" method="post" action="verify-otp" class="hidden">
        <label for="otp">Enter the OTP sent to your email:</label>
        <input type="text" name="otp" id="otp" required>
        <input type="hidden" name="username" id="otpUsername">
        <input type="submit" value="Verify OTP">
    </form>

    <!-- Step 3: Reset Password -->
    <form id="resetPasswordForm" method="post" action="reset-password" class="hidden">
        <label for="newPassword">New Password:</label>
        <input type="password" name="newPassword" id="newPassword" required>

        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" name="confirmPassword" id="confirmPassword" required>

        <input type="hidden" name="username" id="resetUsername">
        <input type="submit" value="Update Password">
    </form>
</div>

<script>
    // Simulated flow control (update these with real status checks via backend if needed)
    document.getElementById('usernameForm').onsubmit = function (e) {
        e.preventDefault();
        const username = document.getElementById('username').value;
        
        // Send OTP via AJAX or server (you'll handle in backend)
        document.getElementById('otpUsername').value = username;
        document.getElementById('resetUsername').value = username;
        
        document.getElementById('usernameForm').classList.add('hidden');
        document.getElementById('otpForm').classList.remove('hidden');
    };

    document.getElementById('otpForm').onsubmit = function (e) {
        e.preventDefault();
        // Validate OTP via backend in real flow
        document.getElementById('otpForm').classList.add('hidden');
        document.getElementById('resetPasswordForm').classList.remove('hidden');
    };
</script>
</body>
</html>
