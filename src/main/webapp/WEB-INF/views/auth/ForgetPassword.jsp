<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #ffffff;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            width: 100%;
            max-width: 450px;
            background: #ffffff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid #e1e5e9;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .container:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }

        .container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
            font-size: 28px;
            font-weight: 600;
            position: relative;
        }

        .container h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: #3498db;
            border-radius: 2px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #34495e;
            font-weight: 500;
            font-size: 14px;
        }

        input[type=text], input[type=password] {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
            color: #2c3e50;
        }

        input[type=text]:focus, input[type=password]:focus {
            outline: none;
            border-color: #3498db;
            background-color: #fff;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            transform: translateY(-2px);
        }

        input::placeholder {
            color: #7f8c8d;
            font-size: 14px;
        }

        button {
            width: 100%;
            background: #3498db;
            color: white;
            padding: 15px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        button:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.3);
        }

        button:active {
            transform: translateY(0);
        }

        .error-message {
            color: #e74c3c;
            margin-bottom: 20px;
            padding: 12px;
            background-color: #fdf2f2;
            border: 1px solid #f5c6cb;
            border-radius: 8px;
            font-size: 14px;
            border-left: 4px solid #e74c3c;
            animation: shake 0.5s ease-in-out;
        }

        .info-message {
            color: #27ae60;
            margin-bottom: 20px;
            padding: 12px;
            background-color: #f0f9f0;
            border: 1px solid #c3e6cb;
            border-radius: 8px;
            font-size: 14px;
            border-left: 4px solid #27ae60;
            animation: fadeIn 0.5s ease-in-out;
        }

        .readonly-text {
            padding: 15px 20px;
            background: #f8f9fa;
            border-radius: 12px;
            font-weight: 600;
            color: #495057;
            border: 2px solid #dee2e6;
        }

        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }

        .step {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 10px;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .step.active {
            background: #3498db;
            color: white;
            transform: scale(1.1);
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
        }

        .step.inactive {
            background-color: #ecf0f1;
            color: #7f8c8d;
            border: 2px solid #bdc3c7;
        }

        .password-strength {
            margin-top: 8px;
            font-size: 12px;
        }

        .strength-weak { color: #e74c3c; }
        .strength-medium { color: #f39c12; }
        .strength-strong { color: #27ae60; }

        @keyframes shake {
            0%, 20%, 40%, 60%, 80%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Professional styling for Arise branding */
        .arise-brand {
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 700;
            color: #2c3e50;
            letter-spacing: 2px;
        }

        .arise-brand::before,
        .arise-brand::after {
            content: '✦';
            margin: 0 15px;
            color: #3498db;
        }

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            .container {
                padding: 30px 25px;
                max-width: 100%;
            }

            .container h2 {
                font-size: 24px;
                margin-bottom: 25px;
            }

            input[type=text], input[type=password] {
                padding: 12px 15px;
                font-size: 16px;
            }

            button {
                padding: 12px;
                font-size: 15px;
            }

            .step {
                width: 35px;
                height: 35px;
                margin: 0 8px;
                font-size: 14px;
            }

            .arise-brand {
                font-size: 20px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 25px 20px;
                border-radius: 15px;
            }

            .container h2 {
                font-size: 22px;
            }

            .step {
                width: 30px;
                height: 30px;
                margin: 0 5px;
                font-size: 12px;
            }
        }

        @media (max-width: 360px) {
            .container {
                padding: 20px 15px;
            }

            input[type=text], input[type=password] {
                padding: 10px 12px;
            }

            button {
                padding: 10px;
            }
        }

        /* High contrast mode */
        @media (prefers-contrast: high) {
            .container {
                border: 3px solid #2c3e50;
            }

            input[type=text], input[type=password] {
                border: 2px solid #2c3e50;
            }

            button {
                background: #2c3e50;
                border: 2px solid #2c3e50;
            }
        }

        /* Reduced motion support */
        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }
    </style>
</head>
<body>


<div class="container">
    <div class="arise-brand">ARISE</div>
    <h2>Forgot Password</h2>

    <!-- Step Indicator -->
    <div class="step-indicator">
        <div class="step ${empty otpSent and empty otpVerified ? 'active' : 'inactive'}">1</div>
        <div class="step ${otpSent and empty otpVerified ? 'active' : 'inactive'}">2</div>
        <div class="step ${otpVerified ? 'active' : 'inactive'}">3</div>
    </div>

    <c:if test="${error != null}">
        <div class="error-message">${error}</div>
    </c:if>

    <c:if test="${info != null}">
        <div class="info-message">${info}</div>
    </c:if>

    <!-- Step 1: Enter Email or Username -->
    <c:if test="${empty otpSent and empty otpVerified}">
        <form method="post" action="/arise/uservalidate">
            <div class="form-group">
                <label for="emailOrUsername">Email or Username</label>
                <input type="text" 
                       id="emailOrUsername"
                       name="emailOrUsername" 
                       placeholder="Enter your email or username"
                       value="${emailOrUsername != null ? emailOrUsername : ''}" 
                       required
                       autocomplete="username"/>
            </div>
            <button type="submit">Send OTP</button>
        </form>
    </c:if>

    <!-- Step 2: Enter OTP -->
    <c:if test="${otpSent}">
        <form method="post" action="/arise/otpvalidate">
            <div class="form-group">
                <label>Email or Username:</label>
                <div class="readonly-text">${emailOrUsername}</div>
            </div>
            <input type="hidden" name="emailOrUsername" value="${emailOrUsername}" />
            <div class="form-group">
                <label for="otp">One-Time Password</label>
                <input type="text" 
                       id="otp"
                       name="otp" 
                       placeholder="Enter 6-digit OTP" 
                       maxlength="6"
                       pattern="[0-9]{6}"
                       required
                       autocomplete="one-time-code"/>
            </div>
            <button type="submit">Verify OTP</button>
        </form>
    </c:if>

    <!-- Step 3: Reset Password -->
    <c:if test="${otpVerified}">
        <form method="post" action="/arise/updatePassword" onsubmit="return validatePassword();">
            <div class="form-group">
                <label>Email or Username:</label>
                <div class="readonly-text">${emailOrUsername}</div>
            </div>
            <input type="hidden" name="emailOrUsername" value="${emailOrUsername}" />

            <div class="form-group">
                <label for="newPassword">New Password</label>
                <input type="password" 
                       name="password" 
                       id="newPassword"
                       placeholder="Enter new password" 
                       required 
                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
                       title="Password must be at least 8 characters and include uppercase, lowercase, number, and symbol."
                       autocomplete="new-password"
                       oninput="checkPasswordStrength()"/>
                <div id="passwordStrength" class="password-strength"></div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" 
                       name="confirmPassword" 
                       id="confirmPassword"
                       placeholder="Confirm your password" 
                       required
                       autocomplete="new-password"/>
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
        return false;
    }
    return true;
}

function checkPasswordStrength() {
    const password = document.getElementById("newPassword").value;
    const strengthDiv = document.getElementById("passwordStrength");
    
    if (password.length === 0) {
        strengthDiv.innerHTML = "";
        return;
    }
    
    let strength = 0;
    const checks = [
        { regex: /.{8,}/, message: "At least 8 characters" },
        { regex: /[a-z]/, message: "Lowercase letter" },
        { regex: /[A-Z]/, message: "Uppercase letter" },
        { regex: /\d/, message: "Number" },
        { regex: /[@$!%*?&]/, message: "Special character" }
    ];
    
    checks.forEach(check => {
        if (check.regex.test(password)) strength++;
    });
    
    if (strength < 3) {
        strengthDiv.innerHTML = '<span class="strength-weak">Weak password</span>';
    } else if (strength < 5) {
        strengthDiv.innerHTML = '<span class="strength-medium">Medium password</span>';
    } else {
        strengthDiv.innerHTML = '<span class="strength-strong">Strong password</span>';
    }
}

// Auto-format OTP input (if on step 2)
document.addEventListener('DOMContentLoaded', function() {
    const otpInput = document.getElementById('otp');
    if (otpInput) {
        otpInput.addEventListener('input', function(e) {
            this.value = this.value.replace(/\D/g, '');
        });
    }
});
</script>

</body>
</html>