<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Arize - SignIn</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        #header-title {
            color: white;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .home-btn {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border: 2px solid white;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .home-btn:hover {
            background: white;
            color: #667eea;
        }

        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }

        .auth-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            width: 100%;
            max-width: 450px;
        }

        .tab-buttons {
            display: flex;
            margin-bottom: 2rem;
            background: #f8f9fa;
            border-radius: 10px;
            padding: 0.25rem;
        }

        .tab-btn {
            flex: 1;
            padding: 0.75rem;
            border: none;
            background: transparent;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .tab-btn.active {
            background: white;
            color: #667eea;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .form-section {
            display: none;
        }

        .form-section.active {
            display: block;
        }

        .form-section form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        label {
            font-weight: 500;
            color: #333;
            margin-bottom: 0.25rem;
        }

        input {
            padding: 0.75rem;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: #667eea;
        }

        .password-wrapper {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #666;
        }

        button[type="submit"] {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 0.875rem;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease;
        }

        button[type="submit"]:hover {
            transform: translateY(-2px);
        }

        .oauth-divider {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
            color: #666;
        }

        .oauth-divider::before,
        .oauth-divider::after {
            content: '';
            height: 1px;
            background: #e1e5e9;
            flex: 1;
        }

        .oauth-divider span {
            padding: 0 1rem;
            font-size: 0.875rem;
        }

        .google-signin-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            padding: 0.875rem;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            background: white;
            color: #333;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-bottom: 1rem;
        }

        .google-signin-btn:hover {
            border-color: #4285f4;
            background: #f8f9ff;
        }

        .google-icon {
            width: 20px;
            height: 20px;
            background: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTgiIGhlaWdodD0iMTgiIHZpZXdCb3g9IjAgMCAxOCAxOCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgPHBhdGggZD0iTTE3LjY0IDkuMjA0NzI3MjdjMC0uNjM5NjM2MzctLjA1NzI3MjczLTEuMjUyNzI3MjctLjE2MzYzNjM2LTEuODQwOTA5MDlIOXY0LjAwOTA5MDloNC44NDQwOTA5Yy0uMjEzNjM2MzYgMS4xMjk1NDU0NS0uODU2MzYzNjQgMi4wODYzNjM2NC0xLjgzNDU0NTQ1IDIuNzI5MDkwOVYxNC4wNGgzLjAwNTQ1NDU0Yy43NDkwOTA5MS0uNjg3MjcyNzMgMS4xMjE4MTgxOC0xLjY5ODYzNjM2Ljk4NDU0NTQ1LTIuNzE5NTQ1NDVsLTIuMzEtMy4xMTYzNjM2NFoiIGZpbGw9IiM0Mjg1RjQiLz4KICAgIDxwYXRoIGQ9Ik05IDE4Yy0yLjg3MjcyNzMgMC01LjIyNzI3MjczLTEuMTQzNjM2MzYtNi44OC0zLjE0NzI3MjczaDIuNjA0NTQ1NDVjMS4xMDQ1NDU0NS43MTI3MjcyNyAyLjQxODE4MTgyIDEuMTI5MDkwOTEgNC4yNzU0NTQ1NSAxLjEyOTA5MDkxIDEuNTU0NTQ1NDUgMCAyLjg5NTQ1NDU1LS41MTgxODE4MiAzLjg2NzI3MjczLTEuNDA1NDU0NTVsMi4zMSAzLjExNjM2MzY0QzE0LjIxNDU0NTQ1IDE2Ljg1NjM2MzY0IDExLjgxNjM2MzY0IDE4IDkgMTh6IiBmaWxsPSIjMzRBODUzIi8+CiAgICA8cGF0aCBkPSJNOS4wMTM2MzYzNiA3LjQyNzI3MjczYzEuMDIyNzI3MjcgMCAxLjkzNjM2MzY0LjM1MDkwOTA5IDIuNjU4MTgxODIgMS4wNDA5MDkwOWwyLjUyNy0yLjUyN0MxMi45NjM2MzY0IDQuNjQ1NDU0NTUgMTEuMjM2MzYzNiAzLjg5MDkwOTA5IDkgMy44OTA5MDkwOSA1LjY3MjcyNzI3IDMuODkwOTA5MDkgMi45NzI3MjcyNyA1LjY0MDkwOTA5IDEuODYzNjM2MzYgOC4xMDQ1NDU0NWgyLjYwNDU0NTQ1QzUuMTY4MTgxODIgNi44NjM2MzYzNiA2Ljg3MjcyNzI3IDUuNTMxODE4MTggOSA1LjUzMTgxODE4eiIgZmlsbD0iI0ZCQkMwNSIvPgogICAgPHBhdGggZD0iTTEuODYzNjM2MzYgOC4xMDQ1NDU0NWgtMi42MDQ1NDU0NUMwLjM0MDkwOTA5IDEwLjI0MDkwOTEgMCA5LjY0MDkwOTA5IDAgOXMuMzQwOTA5MDktMS4yNDA5MDkwOS44MjI3MjcyNy0zLjI3MjcyNzI3bDIuNjA0NTQ1NDUgMi4zNzE4MTgxOEMzLjMyMTgxODE4IDEwLjc5MDkwOTEgMy40MjE4MTgxOCAxMy41MjcyNzI3IDQuMjI3MjcyNzMgMTQuNzI3MjcyN0w2LjUxODE4MTgyIDEyLjUwOTA5MDljLS42ODM2MzYzNi0uNDE2MzYzNjQtMS4yMzI3MjcyNy0uOTIzNjM2MzYtMS42NTQ1NDU0NS0xLjQ5NDU0NTQ1eiIgZmlsbD0iI0VBNDMzNSIvPgogIDwvZz4KPC9zdmc+') no-repeat center;
            background-size: contain;
        }

        .error-msg {
            background: #fee;
            color: #c33;
            padding: 0.75rem;
            border-radius: 8px;
            border-left: 4px solid #c33;
            font-size: 0.875rem;
        }

        .links {
            text-align: center;
            margin: 1rem 0;
        }

        .links a {
            color: #667eea;
            text-decoration: none;
            font-size: 0.875rem;
        }

        .links a:hover {
            text-decoration: underline;
        }

        .switch-text {
            text-align: center;
            font-size: 0.875rem;
            color: #666;
        }

        .switch-link {
            color: #667eea;
            cursor: pointer;
            font-weight: 500;
        }

        .switch-link:hover {
            text-decoration: underline;
        }

        .recaptcha-container {
            margin: 1rem 0;
            display: flex;
            justify-content: center;
        }
    </style>
</head>
<body>
    <header>
        <h1 id="header-title">Arize - SignIn</h1>
        <a href="/" class="home-btn">Home</a>
    </header>

<main>
    <div class="auth-container">
        <div class="tab-buttons">
            <button class="tab-btn active" onclick="switchTab('login')">Sign In</button>
            <button class="tab-btn" onclick="switchTab('register')">Sign Up</button>
        </div>

        <div class="form-container">
            <!-- Login Form -->
            <div id="login-form" class="form-section active">
                <!-- Google OAuth2 Sign In -->
                <a href="/oauth2/authorization/google" class="google-signin-btn">
                    <div class="google-icon"></div>
                    Sign in with Google
                </a>

                <div class="oauth-divider">
                    <span>or continue with email</span>
                </div>

                <form id="loginForm" action="/arise/login" method="post">
                    <label for="login-username">User name</label> 
                    <input type="text" id="login-username" name="username" required> 

                    <label for="login-password">Password</label>
                    <div class="password-wrapper">
                        <input type="password" name="password" id="login-password" required>
                        <i class="fas fa-eye password-toggle" onclick="togglePassword('login-password', this)"></i>
                    </div>

                    <!-- reCAPTCHA (shows after 2 failed attempts) -->
                    <div id="recaptcha-container" class="recaptcha-container" style="display: none;">
                        <div class="g-recaptcha" data-sitekey="6Ldl-VArAAAAAAlU_PMEXmBCzeF8Go5E3EvSpWHV"></div>
                    </div>

                    <!-- Error Messages -->
                    <div id="login-error" class="error-msg" style="display: none;"></div>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="error-msg">
                            <% if ("CAPTCHA_FAILED".equals(request.getAttribute("error"))) { %>
                                CAPTCHA verification failed. Please try again.
                            <% } else { %>
                                Login failed. Please check your credentials.
                            <% } %>
                        </div>
                    <% } %>

                    <c:if test="${not empty loginError}">
                        <div style="color: red; margin-bottom: 10px;">
                            <c:choose>
                                <c:when test="${loginError == 'USER_NOT_FOUND'}">
                                    User details not found.
                                </c:when>
                                <c:when test="${loginError == 'PASSWORD_MISMATCH'}">
                                    Username and password mismatch.
                                </c:when>
                                <c:otherwise>
                                    ${loginError}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>

                    <button type="submit">Login</button>

                    <div class="links">
                        <a href="/arise/forget">Forgot Password?</a>
                    </div>

                    <div class="switch-text">
                        Don't have an account? <span class="switch-link" onclick="switchTab('register')">Sign up here</span>
                    </div>
                </form>
            </div>

            <!-- Registration Form -->
            <div id="register-form" class="form-section">
                <!-- Google OAuth2 Sign Up -->
                <a href="/oauth2/authorization/google" class="google-signin-btn">
                    <div class="google-icon"></div>
                    Sign up with Google
                </a>

                <div class="oauth-divider">
                    <span>or create account with email</span>
                </div>

    <form action="/arise/validation" method="post" novalidate onsubmit="return validateForm();">
    <div class="error-message">
        <span th:if="${error}" th:text="${error}" style="color: red;"></span>
    </div>

    <label for="name">Name</label>
    <input type="text" id="name" name="name" required/>

    <label for="username">User Name</label>
    <input type="text" id="username" name="username" required/>

    <label for="email">E-mail</label>
    <input type="email" id="email" name="email" required/>

    <label for="password">Create Password</label>
    <div class="password-wrapper">
        <input type="password" id="password" name="password" required/>
        <i class="fas fa-eye password-toggle" onclick="togglePassword('password', this)"></i>
    </div>

    <label for="cpass">Confirm Password</label>
    <div class="password-wrapper">
        <input type="password" id="cpass" name="cpass" required/>
        <i class="fas fa-eye password-toggle" onclick="togglePassword('cpass', this)"></i>
    </div>

    <button type="submit">Register</button>

    <div class="switch-text">
        Already have an account? <span class="switch-link" onclick="switchTab('login')">Sign in here</span>
    </div>
</form>
            </div>
        </div>
    </div>
</main>
    <script>
        // Check if reCAPTCHA should be shown (from server-side session)
        <% 
        Integer attempts = (Integer) session.getAttribute("ATTEMPTS");
        if (attempts != null && attempts >= 2) {
        %>
            document.addEventListener('DOMContentLoaded', function() {
                document.getElementById('recaptcha-container').style.display = 'block';
            });
        <% } %>

        function switchTab(tab) {
            const loginTab = document.querySelector('.tab-btn:first-child');
            const registerTab = document.querySelector('.tab-btn:last-child');
            const loginForm = document.getElementById('login-form');
            const registerForm = document.getElementById('register-form');
            const headerTitle = document.getElementById('header-title');
            
            if (tab === 'login') {
                loginTab.classList.add('active');
                registerTab.classList.remove('active');
                loginForm.classList.add('active');
                registerForm.classList.remove('active');
                headerTitle.textContent = 'Arize - Login';
            } else {
                registerTab.classList.add('active');
                loginTab.classList.remove('active');
                registerForm.classList.add('active');
                loginForm.classList.remove('active');
                headerTitle.textContent = 'Arize - Sign Up';
            }
        }

        // Password toggle functionality
        function togglePassword(inputId, icon) {
            const input = document.getElementById(inputId);
            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                input.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }

        // Registration form validation
        function validateForm() {
            const name = document.getElementById("name").value.trim();
            const email = document.getElementById("email").value.trim();
            const mobile = document.getElementById("mobile").value.trim();
            const password = document.getElementById("password").value;
            const cpass = document.getElementById("cpass").value;

            const nameRegex = /^[A-Za-z\s]+$/;
            if (!nameRegex.test(name)) {
                alert("Name must contain only letters and spaces.");
                return false;
            }

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }

            const mobileRegex = /^[6-9]\d{9}$/;
            if (!mobileRegex.test(mobile)) {
                alert("Mobile number must be 10 digits and start with 6, 7, 8, or 9.");
                return false;
            }

            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#\$%@&\*])[A-Za-z\d#\$%@&\*]{8,}$/;
            if (!passwordRegex.test(password)) {
                alert("Password must be at least 8 characters long and include uppercase, lowercase, number, and special character (#$%@&*).");
                return false;
            }

            if (password !== cpass) {
                alert("Confirm password does not match the password.");
                return false;
            }

            return true;
        }

        // Handle URL parameters to show appropriate form
        window.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const tab = urlParams.get('tab');
            
            if (tab === 'register') {
                switchTab('register');
            }

            // Check for error messages in URL
            const error = urlParams.get('error');
            if (error) {
                const errorDiv = document.getElementById('login-error');
                if (error === 'otp-mismatch') {
                    errorDiv.textContent = 'OTP verification failed. Please try again.';
                } else {
                    errorDiv.textContent = 'Login failed. Please check your credentials.';
                }
                errorDiv.style.display = 'block';
            }

            const logout = urlParams.get('logout');
            if (logout) {
                console.log('Successfully logged out');
            }
        });
        
        document.getElementById("loginForm").addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent default form submission

            let formData = new FormData(this);

            fetch("/arise/login", {
                method: "POST",
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.token) {
                    localStorage.setItem("jwtToken", data.token); // Store JWT
                    window.location.href = data.redirect; // Redirect after storing token
                }
            })
            .catch(error => console.error("Login error:", error));
        });
    
    </script>
</body>
</html>