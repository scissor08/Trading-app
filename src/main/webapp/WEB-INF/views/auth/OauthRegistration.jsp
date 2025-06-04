<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Registration</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 420px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transform: translateY(0);
            transition: all 0.3s ease;
        }

        .form-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
        }

        .form-title {
            text-align: center;
            color: #333;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .form-subtitle {
            text-align: center;
            color: #666;
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
            color: #444;
            font-weight: 500;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
            outline: none;
        }

        input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-1px);
        }

        input:focus + label,
        input:not(:placeholder-shown) + label {
            color: #667eea;
        }

        input[readonly] {
            background: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
        }

        input[readonly]:focus {
            border-color: #e1e5e9;
            box-shadow: none;
            transform: none;
        }

        .password-requirements {
            font-size: 0.8rem;
            color: #666;
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
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
            color: #999;
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
            .form-container {
                padding: 2rem 1.5rem;
                margin: 10px;
            }
        }
    </style>
</head>
<body>
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
                requirements.style.color = '#28a745';
                requirements.textContent = '✓ Password meets requirements';
            } else {
                requirements.style.color = '#666';
                requirements.textContent = 'Password should be at least 8 characters with letters and numbers';
            }
        });
    </script>
</body>
</html>