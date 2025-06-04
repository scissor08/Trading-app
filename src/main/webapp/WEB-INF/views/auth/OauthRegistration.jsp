<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Registration - Arise</title>
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
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .header-logo {
            position: absolute;
            top: 30px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 2rem;
            font-weight: 700;
            color: #2c3e50;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .form-container {
            background: #ffffff;
            border: 2px solid #e8e9ea;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 420px;
            transform: translateY(0);
            transition: all 0.3s ease;
            margin-top: 60px;
        }

        .form-container:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
            border-color: #d1d3d4;
        }

        .form-title {
            text-align: center;
            color: #2c3e50;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .form-subtitle {
            text-align: center;
            color: #7f8c8d;
            margin-bottom: 2rem;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            color: #34495e;
            font-weight: 500;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e8e9ea;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
            outline: none;
            color: #2c3e50;
        }

        input:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            transform: translateY(-1px);
        }

        input:focus + label,
        input:not(:placeholder-shown) + label {
            color: #3498db;
        }

        input[readonly] {
            background: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
        }

        input[readonly]:focus {
            border-color: #e8e9ea;
            box-shadow: none;
            transform: none;
        }

        .password-requirements {
            font-size: 0.8rem;
            color: #7f8c8d;
            margin-top: 0.5rem;
            opacity: 0;
            transform: translateY(-10px);
            transition: all 0.3s ease;
        }

        input[type="password"]:focus ~ .password-requirements {
            opacity: 1;
            transform: translateY(0);
        }

        .submit-btn {
            width: 100%;
            padding: 14px;
            background: #2c3e50;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .submit-btn:hover {
            background: #34495e;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(44, 62, 80, 0.3);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .readonly-indicator {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 0.8rem;
            color: #27ae60;
            pointer-events: none;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-container {
            animation: fadeInUp 0.6s ease-out;
        }

        .form-group:nth-child(2) { animation-delay: 0.1s; }
        .form-group:nth-child(3) { animation-delay: 0.2s; }
        .form-group:nth-child(4) { animation-delay: 0.3s; }
        .submit-btn { animation-delay: 0.4s; }

        .form-group {
            animation: fadeInUp 0.6s ease-out both;
        }

        @media (max-width: 480px) {
            .header-logo {
                font-size: 1.5rem;
                top: 20px;
            }
            
            .form-container {
                padding: 2rem 1.5rem;
                margin: 10px;
                margin-top: 80px;
            }
        }
    </style>
</head>
<body>
    <div class="header-logo">ARISE</div>
    
    <div class="form-container">
        <h1 class="form-title">Complete Registration</h1>
        <p class="form-subtitle">Set your password to finish setting up your account</p>
        
        <form action="/oauth2/setup-password" method="post">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" value="${username}" readonly>
                <span class="readonly-indicator">✓ Verified</span>
            </div>
            
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="${email}" readonly>
                <span class="readonly-indicator">✓ Verified</span>
            </div>
            
            <div class="form-group">
                <label for="password">Set Password</label>
                <input type="password" id="password" name="password" required placeholder="Enter your password">
                <div class="password-requirements">
                    Password should be at least 8 characters with letters and numbers
                </div>
            </div>
            
            <button type="submit" class="submit-btn">Complete Registration</button>
        </form>
    </div>

    <script>
        // Add some interactive feedback
        const form = document.querySelector('form');
        const submitBtn = document.querySelector('.submit-btn');
        const passwordInput = document.getElementById('password');

        // Password strength indicator
        passwordInput.addEventListener('input', function() {
            const value = this.value;
            const requirements = document.querySelector('.password-requirements');
            
            if (value.length >= 8 && /[A-Za-z]/.test(value) && /\d/.test(value)) {
                requirements.style.color = '#27ae60';
                requirements.textContent = '✓ Password meets requirements';
            } else {
                requirements.style.color = '#7f8c8d';
                requirements.textContent = 'Password should be at least 8 characters with letters and numbers';
            }
        });
    </script>
</body>
</html>