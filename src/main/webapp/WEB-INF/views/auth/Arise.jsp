<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Arize - SignIn</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
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
	flex-direction: column;
	color: #333;
}



.home-btn {
	color: #2c3e50;
	text-decoration: none;
	padding: 0.6rem 1.2rem;
	border: 2px solid #2c3e50;
	border-radius: 8px;
	transition: all 0.3s ease;
	font-weight: 500;
}

.home-btn:hover {
	background: #2c3e50;
	color: white;
	transform: translateY(-1px);
}

main {
	flex: 1;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 2rem;
	background: #f8f9fa;
}

.auth-container {
	background: #ffffff;
	border-radius: 12px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	padding: 2.5rem;
	width: 100%;
	max-width: 450px;
	border: 1px solid #e0e0e0;
}

.tab-buttons {
	display: flex;
	margin-bottom: 2rem;
	background: #f8f9fa;
	border-radius: 8px;
	padding: 0.25rem;
	border: 1px solid #e0e0e0;
}

.tab-btn {
	flex: 1;
	padding: 0.75rem;
	border: none;
	background: transparent;
	border-radius: 6px;
	cursor: pointer;
	font-weight: 500;
	transition: all 0.3s ease;
	color: #666;
}

.tab-btn.active {
	background: white;
	color: #2c3e50;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	font-weight: 600;
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
	color: #2c3e50;
	margin-bottom: 0.25rem;
}

input {
	padding: 0.875rem;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 1rem;
	transition: all 0.3s ease;
	background: #ffffff;
}

input:focus {
	outline: none;
	border-color: #3498db;
	box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
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
	background: #2c3e50;
	color: white;
	border: none;
	padding: 1rem;
	border-radius: 8px;
	font-size: 1rem;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
}

button[type="submit"]:hover {
	background: #34495e;
	transform: translateY(-1px);
	box-shadow: 0 4px 12px rgba(44, 62, 80, 0.3);
}

.oauth-divider {
	display: flex;
	align-items: center;
	margin: 1.5rem 0;
	color: #666;
}

.oauth-divider::before, .oauth-divider::after {
	content: '';
	height: 1px;
	background: #e0e0e0;
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
	border: 2px solid #e0e0e0;
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
	transform: translateY(-1px);
	box-shadow: 0 4px 12px rgba(66, 133, 244, 0.2);
}

.google-icon {
	width: 20px;
	height: 20px;
	background:
		url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTgiIGhlaWdodD0iMTgiIHZpZXdCb3g9IjAgMCAxOCAxOCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgPHBhdGggZD0iTTE3LjY0IDkuMjA0NzI3MjdjMC0uNjM5NjM2MzctLjA1NzI3MjczLTEuMjUyNzI3MjctLjE2MzYzNjM2LTEuODQwOTA5MDlIOXY0LjAwOTA5MDloNC44NDQwOTA5Yy0uMjEzNjM2MzYgMS4xMjk1NDU0NS0uODU2MzYzNjQgMi4wODYzNjM2NC0xLjgzNDU0NTQ1IDIuNzI5MDkwOVYxNC4wNGgzLjAwNTQ1NDU0Yy43NDkwOTA5MS0uNjg3MjcyNzMgMS4xMjE4MTgxOC0xLjY5ODYzNjM2Ljk4NDU0NTQ1LTIuNzE5NTQ1NDVsLTIuMzEtMy4xMTYzNjM2NFoiIGZpbGw9IiM0Mjg1RjQiLz4KICAgIDxwYXRoIGQ9Ik05IDE4Yy0yLjg3MjcyNzMgMC01LjIyNzI3MjczLTEuMTQzNjM2MzYtNi44OC0zLjE0NzI3MjczaDIuNjA0NTQ1NDVjMS4xMDQ1NDU0NS43MTI3MjcyNyAyLjQxODE4MTgyIDEuMTI5MDkwOTEgNC4yNzU0NTQ1NSAxLjEyOTA5MDkxIDEuNTU0NTQ1NDUgMCAyLjg5NTQ1NDU1LS41MTgxODE4MiAzLjg2NzI3MjczLTEuNDA1NDU0NTVsMi4zMSAzLjExNjM2MzY0QzE0LjIxNDU0NTQ1IDE2Ljg1NjM2MzY0IDExLjgxNjM2MzY0IDE4IDkgMTh6IiBmaWxsPSIjMzRBODUzIi8+CiAgICA8cGF0aCBkPSJNOS4wMTM2MzYzNiA3LjQyNzI3MjczYzEuMDIyNzI3MjcgMCAxLjkzNjM2MzY0LjM1MDkwOTA5IDIuNjU4MTgxODIgMS4wNDA5MDkwOWwyLjUyNy0yLjUyN0MxMi45NjM2MzY0IDQuNjQ1NDU0NTUgMTEuMjM2MzYzNiAzLjg5MDkwOTA5IDkgMy44OTA5MDkwOSA1LjY3MjcyNzI3IDMuODkwOTA5MDkgMi45NzI3MjcyNyA1LjY0MDkwOTA5IDEuODYzNjM2MzYgOC4xMDQ1NDU0NWgyLjYwNDU0NTQ1QzUuMTY4MTgxODIgNi44NjM2MzYzNiA2Ljg3MjcyNzI3IDUuNTMxODE4MTggOSA1LjUzMTgxODE4eiIgZmlsbD0iI0ZCQkMwNSIvPgogICAgPHBhdGggZD0iTTEuODYzNjM2MzYgOC4xMDQ1NDU0NWgtMi42MDQ1NDU0NUMwLjM0MDkwOTA5IDEwLjI0MDkwOTEgMCA5LjY0MDkwOTA5IDAgOXMuMzQwOTA5MDktMS4yNDA5MDkwOS44MjI3MjcyNy0zLjI3MjcyNzI3bDIuNjA0NTQ1NDUgMi4zNzE4MTgxOEMzLjMyMTgxODE4IDEwLjc5MDkwOTEgMy40MjE4MTgxOCAxMy41MjcyNzI3IDQuMjI3MjcyNzMgMTQuNzI3MjcyN0w2LjUxODE4MTgyIDEyLjUwOTA5MDljLS42ODM2MzYzNi0uNDE2MzYzNjQtMS4yMzI3MjcyNy0uOTIzNjM2MzYtMS42NTQ1NDU0NS0xLjQ5NDU0NTQ1eiIgZmlsbD0iI0VBNDMzNSIvPgogIDwvZz4KPC9zdmc+')
		no-repeat center;
	background-size: contain;
}

.error-msg {
	background: #fee;
	color: #c33;
	padding: 0.75rem;
	border-radius: 8px;
	border-left: 4px solid #e74c3c;
	font-size: 0.875rem;
	margin-bottom: 1rem;
}

.success-msg {
	background: #e8f5e8;
	color: #27ae60;
	padding: 0.75rem;
	border-radius: 8px;
	border-left: 4px solid #27ae60;
	font-size: 0.875rem;
	margin-bottom: 1rem;
}

.links {
	text-align: center;
	margin: 1rem 0;
}

.links a {
	color: #3498db;
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
	color: #3498db;
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

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    margin-top: 70px;
    background-color: #f5f5f5;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* Main Header */
.main-header {
    background-color: #f8f9fa;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    width: 100%;
    height: 70px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    z-index: 1000;
    border-bottom: 1px solid #e0e0e0;
}

.header-container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 100%;
    padding: 0 2rem;
    max-width: 1400px;
    margin: 0 auto;
}

/* Logo Section */
.header-logo {
    flex-shrink: 0;
}

.logo-link {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: #333;
    font-weight: 700;
    font-size: 1.2rem;
    transition: color 0.3s ease;
}

.logo-link:hover {
    color: #007bff;
}

.logo-icon {
    font-size: 1.8rem;
    margin-right: 0.5rem;
    color: #007bff;
}

.logo-text {
    font-weight: 700;
    letter-spacing: -0.5px;
}

/* Navigation */
.header-nav {
    display: flex;
    align-items: center;
    gap: 2rem;
    flex-grow: 1;
    justify-content: center;
}

.nav-link {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    text-decoration: none;
    color: #333;
    font-weight: 500;
    font-size: 0.95rem;
    padding: 0.5rem 1rem;
    border-radius: 6px;
    transition: all 0.3s ease;
    white-space: nowrap;
}

.nav-link:hover {
    color: #007bff;
    background-color: rgba(0, 123, 255, 0.1);
}

.nav-link i {
    font-size: 1rem;
}

/* Right Section */
.header-right {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    flex-shrink: 0;
}

/* Search Container */
.search-container {
    position: relative;
}

.search-box {
    display: flex;
    align-items: center;
    background: white;
    border: 1px solid #ced4da;
    border-radius: 25px;
    padding: 0.4rem 0.8rem;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.search-box:focus-within {
    border-color: #007bff;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
}

.search-icon {
    color: #6c757d;
    font-size: 0.9rem;
    margin-right: 0.5rem;
}

.search-input {
    border: none;
    outline: none;
    background: transparent;
    font-size: 0.9rem;
    width: 200px;
    color: #333;
}

.search-input::placeholder {
    color: #6c757d;
}

.search-btn {
    background: #007bff;
    border: none;
    color: white;
    padding: 0.3rem 0.6rem;
    border-radius: 50px;
    cursor: pointer;
    margin-left: 0.5rem;
    transition: background-color 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
}

.search-btn:hover {
    background: #0056b3;
}

.search-btn i {
    font-size: 0.8rem;
}

/* Profile Dropdown */
.profile-dropdown {
    position: relative;
}

.profile-btn {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    background: none;
    border: none;
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 6px;
    transition: background-color 0.3s ease;
    color: #333;
}

.profile-btn:hover {
    background-color: rgba(0, 123, 255, 0.1);
}

.profile-icon {
    font-size: 1.8rem;
    color: #007bff;
}

.dropdown-arrow {
    font-size: 0.8rem;
    transition: transform 0.3s ease;
}

.profile-btn.active .dropdown-arrow {
    transform: rotate(180deg);
}

.dropdown-menu {
    position: absolute;
    top: calc(100% + 0.5rem);
    right: 0;
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
    min-width: 200px;
    opacity: 0;
    visibility: hidden;
    transform: translateY(-10px);
    transition: all 0.3s ease;
    z-index: 1001;
}

.dropdown-menu.show {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.dropdown-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.75rem 1rem;
    text-decoration: none;
    color: #333;
    font-size: 0.9rem;
    transition: background-color 0.3s ease;
    border-radius: 0;
}

.dropdown-item:hover {
    background-color: #f8f9fa;
}

.dropdown-item i {
    font-size: 1rem;
    width: 16px;
    text-align: center;
}

.dropdown-divider {
    height: 1px;
    background-color: #e0e0e0;
    margin: 0.5rem 0;
}

.logout-item {
    color: #dc3545;
}

.logout-item:hover {
    background-color: rgba(220, 53, 69, 0.1);
}

/* Mobile Menu Button */
.mobile-menu-btn {
    display: none;
    background: none;
    border: none;
    font-size: 1.2rem;
    color: #333;
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

.mobile-menu-btn:hover {
    background-color: rgba(0, 123, 255, 0.1);
}

/* Mobile Navigation */
.mobile-nav {
    display: none;
    background: white;
    border-top: 1px solid #e0e0e0;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.mobile-nav-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem 2rem;
    text-decoration: none;
    color: #333;
    font-weight: 500;
    border-bottom: 1px solid #f0f0f0;
    transition: background-color 0.3s ease;
}

.mobile-nav-item:hover {
    background-color: #f8f9fa;
}

.mobile-nav-item:last-child {
    border-bottom: none;
}

.mobile-search {
    padding: 1rem 2rem;
    border-top: 1px solid #e0e0e0;
}

/* Dropdown Overlay */
.dropdown-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: transparent;
    z-index: 999;
    display: none;
}

.dropdown-overlay.show {
    display: block;
}

/* Responsive Design */
@media (max-width: 1024px) {
    .header-container {
        padding: 0 1.5rem;
    }
    
    .search-input {
        width: 150px;
    }
    
    .header-nav {
        gap: 1.5rem;
    }
}

@media (max-width: 768px) {
    .header-nav {
        display: none;
    }
    
    .search-container {
        display: none;
    }
    
    .mobile-menu-btn {
        display: block;
    }
    
    .mobile-nav.show {
        display: block;
    }
    
    .header-container {
        padding: 0 1rem;
    }
    
    .logo-text {
        display: none;
    }
    
    body {
        margin-top: 70px;
    }
}

@media (max-width: 480px) {
    .header-container {
        padding: 0 0.75rem;
    }
    
    .header-right {
        gap: 1rem;
    }
    
    .search-box {
        padding: 0.3rem 0.6rem;
    }
    
    .mobile-nav-item,
    .mobile-search {
        padding: 0.75rem 1rem;
    }
}

/* Animation for smooth transitions */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.dropdown-menu.show {
    animation: fadeInUp 0.3s ease;
}

.logos {
    height: 180px; /* Adjust the height as per your requirement */
    width: auto; /* Keeps aspect ratio intact */
    max-width: 200px; /* Optional: to prevent it from growing too large */
    transition: all 0.3s ease;
      padding: 1rem;
       margin-top: 10px; 
}

.logos:hover {
    transform: scale(1.05); /* Optional: slight zoom effect on hover */
}
</style>
</head>
<body>
<header class="main-header">
    <div class="header-container">
        <!-- Logo Section -->
        <div class="header-logo">
             <img src="${pageContext.request.contextPath}/images/logo.png" alt="StackTrader Logo" class="logos">
        </div>

        <!-- Navigation Links -->
        <nav class="header-nav">
            
        </nav>


              <a href="/arise" class="home-btn">Home</a>        
        </div>
 
</header>



	<main>
		<div class="auth-container">
			<div class="tab-buttons">
				<button class="tab-btn active" onclick="switchTab('login')">Sign
					In</button>
				<button class="tab-btn" onclick="switchTab('register')">Sign
					Up</button>
			</div>

			<div class="form-container">
				<!-- Login Form -->
				<div id="login-form" class="form-section active">
					<!-- Google OAuth2 Sign In -->
					<a href="/oauth2/authorization/google" class="google-signin-btn">
						<div class="google-icon"></div> Sign in with Google
					</a>

					<div class="oauth-divider">
						<span>or continue with email</span>
					</div>

					<form action="/arise/login" method="post">
						<!-- Success Messages -->
						<c:if test="${param.success == 'registered'}">
							<div class="success-msg">Registration successful! Please sign in.</div>
						</c:if>
						<c:if test="${param.success == 'logout'}">
							<div class="success-msg">You have been logged out successfully.</div>
						</c:if>
						<c:if test="${param.success == 'password_reset'}">
							<div class="success-msg">Password reset successful! Please sign in with your new password.</div>
						</c:if>

						<!-- Error Messages -->
						<c:if test="${param.error == 'INVALID_CREDENTIALS'}">
							<div class="error-msg">Invalid username or password.</div>
						</c:if>
						<c:if test="${param.error == 'exist'}">
							<div class="error-msg">Already Have Accouct Please Signin.</div>
						</c:if>
						<c:if test="${param.error == 'USER_NOT_FOUND'}">
							<div class="error-msg">User not found.</div>
						</c:if>
						<c:if test="${param.error == 'CAPTCHA_REQUIRED'}">
							<div class="error-msg">Please complete the CAPTCHA verification.</div>
						</c:if>
						<c:if test="${param.error == 'CAPTCHA_INVALID'}">
							<div class="error-msg">CAPTCHA verification failed. Please try again.</div>
						</c:if>

						<label for="login-username">Username</label> 
						<input type="text" id="login-username" name="username" required 
							   value="${param.username}" autocomplete="username"> 
						
						<label for="login-password">Password</label>
						<div class="password-wrapper">
							<input type="password" name="password" id="login-password"
								required autocomplete="current-password"> 
							<i class="fas fa-eye password-toggle"
								onclick="togglePassword('login-password', this)"></i>
						</div>

						<!-- Show reCAPTCHA after 2 failed attempts -->
						<c:if test="${param.error == 'CAPTCHA_REQUIRED'}">
							<div class="recaptcha-container">
								<div class="g-recaptcha"
									data-sitekey="6Ldl-VArAAAAAAlU_PMEXmBCzeF8Go5E3EvSpWHV"></div>
							</div>
						</c:if>

						<button type="submit">Sign In</button>

						<div class="links">
							<a href="/arise/forget">Forgot Password?</a>
						</div>

						<div class="switch-text">
							Don't have an account? <span class="switch-link"
								onclick="switchTab('register')">Sign up here</span>
						</div>
					</form>
				</div>

				<!-- Registration Form -->
				<div id="register-form" class="form-section">
					<!-- Google OAuth2 Sign Up -->
					<a href="/oauth2/authorization/google" class="google-signin-btn">
						<div class="google-icon"></div> Sign up with Google
					</a>

					<div class="oauth-divider">
						<span>or create account with email</span>
					</div>

					<form action="/arise/validation" method="post" novalidate
						onsubmit="return validateForm();">
						
						<!-- Error Messages for Registration -->
						<c:if test="${param.error == 'username'}">
							<div class="error-msg">Username already exists! Please choose a different username.</div>
						</c:if>
						<c:if test="${param.error == 'email'}">
							<div class="error-msg">Email already exists! Please use a different email address.</div>
						</c:if>
						<c:if test="${param.error == 'password_mismatch'}">
							<div class="error-msg">Passwords do not match. Please try again.</div>
						</c:if>
						<c:if test="${param.error == 'weak_password'}">
							<div class="error-msg">Password does not meet requirements. Please use a stronger password.</div>
						</c:if>

						<label for="name">Full Name</label> 
						<input type="text" id="name" name="name" required 
							   value="${param.name}" autocomplete="name" />
						
						<label for="username">Username</label>
						<input type="text" id="username" name="username" required 
							   value="${param.username}" autocomplete="username" />

						<label for="email">Email Address</label> 
						<input type="email" id="email" name="email" required 
							   value="${param.email}" autocomplete="email" />

						<label for="password">Create Password</label>
						<div class="password-wrapper">
							<input type="password" id="password" name="password" required 
								   autocomplete="new-password" />
							<i class="fas fa-eye password-toggle"
								onclick="togglePassword('password', this)"></i>
						</div>

						<label for="cpass">Confirm Password</label>
						<div class="password-wrapper">
							<input type="password" id="cpass" name="cpass" required 
								   autocomplete="new-password" /> 
							<i class="fas fa-eye password-toggle"
								onclick="togglePassword('cpass', this)"></i>
						</div>

						<button type="submit">Create Account</button>

						<div class="switch-text">
							Already have an account? <span class="switch-link"
								onclick="switchTab('login')">Sign in here</span>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>

	<script>
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
                headerTitle.textContent = 'Arise - Sign In';
            } else {
                registerTab.classList.add('active');
                loginTab.classList.remove('active');
                registerForm.classList.add('active');
                loginForm.classList.remove('active');
                headerTitle.textContent = 'Arise - Sign Up';
            }
        }
        
        document.addEventListener("DOMContentLoaded", function () {
            const path = window.location.pathname;
            
            if (path.includes("/arise/login")) {
                switchTab("login");
            } else if (path.includes("/arise/registration") || path.includes("/arise/validation")) {
                switchTab("register");
            }
        });


        document.querySelector("form").addEventListener("submit", function(event) {
            var captchaResponse = grecaptcha.getResponse();
            if (!captchaResponse) {
                event.preventDefault(); // Prevent form submission
                alert("CAPTCHA verification is required!");
            }
        });
        
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

        function validateForm() {
            let name = document.getElementById("name").value.trim();
            let username = document.getElementById("username").value.trim();
            let email = document.getElementById("email").value.trim();
            let password = document.getElementById("password").value;
            let cpass = document.getElementById("cpass").value;

            // Name validation
            if (name.length < 2) {
                alert("Name must be at least 2 characters long.");
                return false;
            }

            // Username validation: No spaces allowed, minimum 3 characters
            if (username.length < 3) {
                alert("Username must be at least 3 characters long.");
                return false;
            }
            if (/\s/.test(username)) {
                alert("Username should not contain spaces.");
                return false;
            }

            // Email validation
            let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }

            // Password validation
            let passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            if (!passwordPattern.test(password)) {
                alert("Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character.");
                return false;
            }

            // Confirm Password validation
            if (password !== cpass) {
                alert("Passwords do not match.");
                return false;
            }

            return true; // Proceed with form submission if validation passes
        }

  
        
    </script>
</body>
</html>