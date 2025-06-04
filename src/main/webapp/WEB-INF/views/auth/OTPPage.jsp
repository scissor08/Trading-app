<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Verify OTP</title>
<style>
:root {
	--background: #0a0a0a;
	--card: #1a1a1a;
	--card-hover: #242424;
	--highlight: #FFA500;
	--highlight-hover: #e69500;
	--shadow: rgba(255, 165, 0, 0.15);
	--shadow-strong: rgba(255, 165, 0, 0.3);
	--text-primary: #ffffff;
	--text-secondary: #b0b0b0;
	--error: #ff4757;
	--border: #333;
	--input-bg: #222;
	--input-focus: #2a2a2a;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	background: linear-gradient(135deg, var(--background) 0%, #1a1a2e 100%);
	font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
	color: var(--text-primary);
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
	line-height: 1.6;
}

.otp-container {
	width: 100%;
	max-width: 420px;
	margin: 0 auto;
}

.otp-card {
	background: var(--card);
	background: linear-gradient(145deg, var(--card), #151515);
	padding: 2.5rem;
	border-radius: 16px;
	box-shadow: 
		0 8px 32px var(--shadow),
		0 2px 8px rgba(0, 0, 0, 0.3),
		inset 0 1px 0 rgba(255, 255, 255, 0.1);
	text-align: center;
	border: 1px solid rgba(255, 165, 0, 0.1);
	backdrop-filter: blur(10px);
	transition: all 0.3s ease;
	position: relative;
	overflow: hidden;
}

.otp-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: -100%;
	width: 100%;
	height: 2px;
	background: linear-gradient(90deg, transparent, var(--highlight), transparent);
	animation: shimmer 3s infinite;
}

@keyframes shimmer {
	0% { left: -100%; }
	100% { left: 100%; }
}

.otp-card:hover {
	transform: translateY(-2px);
	box-shadow: 
		0 12px 40px var(--shadow-strong),
		0 4px 12px rgba(0, 0, 0, 0.4),
		inset 0 1px 0 rgba(255, 255, 255, 0.15);
}

.otp-card h2 {
	margin-bottom: 0.5rem;
	color: var(--highlight);
	font-size: 1.8rem;
	font-weight: 600;
	letter-spacing: -0.025em;
}

.otp-card p {
	color: var(--text-secondary);
	margin-bottom: 2rem;
	font-size: 0.95rem;
}

.form-group {
	margin-bottom: 1.5rem;
	text-align: left;
}

.form-group:last-of-type {
	margin-bottom: 2rem;
}

input[type="text"] {
	width: 100%;
	padding: 1rem;
	border: 2px solid var(--border);
	border-radius: 12px;
	background-color: var(--input-bg);
	color: var(--text-primary);
	font-size: 1rem;
	transition: all 0.3s ease;
	outline: none;
	font-family: inherit;
}

input[type="text"]:focus {
	border-color: var(--highlight);
	background-color: var(--input-focus);
	box-shadow: 0 0 0 3px rgba(255, 165, 0, 0.1);
	transform: translateY(-1px);
}

input[type="text"]::placeholder {
	color: #666;
}

.btn-primary {
	background: linear-gradient(135deg, var(--highlight), #ff8c00);
	color: #000;
	padding: 1rem 2rem;
	border: none;
	border-radius: 12px;
	cursor: pointer;
	font-weight: 600;
	font-size: 1rem;
	width: 100%;
	transition: all 0.3s ease;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	box-shadow: 0 4px 12px rgba(255, 165, 0, 0.3);
}

.btn-primary:hover {
	background: linear-gradient(135deg, var(--highlight-hover), #e67300);
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(255, 165, 0, 0.4);
}

.btn-primary:active {
	transform: translateY(0);
}

.btn-secondary {
	background: none;
	border: 2px solid var(--highlight);
	color: var(--highlight);
	padding: 0.8rem 1.5rem;
	border-radius: 12px;
	cursor: pointer;
	font-weight: 500;
	font-size: 0.9rem;
	transition: all 0.3s ease;
	text-decoration: none;
	display: inline-block;
	margin-top: 1rem;
}

.btn-secondary:hover {
	background-color: var(--highlight);
	color: #000;
	transform: translateY(-1px);
	box-shadow: 0 4px 12px rgba(255, 165, 0, 0.2);
}

.error-msg {
	color: var(--error);
	margin-top: 0.8rem;
	font-size: 0.9rem;
	font-weight: 500;
	padding: 0.8rem;
	background: rgba(255, 71, 87, 0.1);
	border-radius: 8px;
	border-left: 3px solid var(--error);
	text-align: left;
}

.actions {
	margin-top: 1.5rem;
	padding-top: 1.5rem;
	border-top: 1px solid var(--border);
}

/* Responsive Design */
@media (max-width: 480px) {
	body {
		padding: 15px;
	}
	
	.otp-card {
		padding: 2rem 1.5rem;
	}
	
	.otp-card h2 {
		font-size: 1.6rem;
	}
	
	.btn-primary {
		padding: 0.9rem 1.5rem;
		font-size: 0.95rem;
	}
	
	.btn-secondary {
		padding: 0.7rem 1.2rem;
		font-size: 0.85rem;
	}
}

@media (max-width: 320px) {
	.otp-card {
		padding: 1.5rem 1rem;
	}
	
	.otp-card h2 {
		font-size: 1.4rem;
	}
	
	input[type="text"] {
		padding: 0.8rem;
		font-size: 0.95rem;
	}
}

/* Dark mode enhancements */
@media (prefers-color-scheme: dark) {
	:root {
		--shadow: rgba(255, 165, 0, 0.2);
		--shadow-strong: rgba(255, 165, 0, 0.35);
	}
}

/* High contrast mode */
@media (prefers-contrast: high) {
	.otp-card {
		border: 2px solid var(--highlight);
	}
	
	input[type="text"] {
		border-width: 3px;
	}
}

/* Reduced motion */
@media (prefers-reduced-motion: reduce) {
	* {
		animation-duration: 0.01ms !important;
		animation-iteration-count: 1 !important;
		transition-duration: 0.01ms !important;
	}
	
	.otp-card::before {
		display: none;
	}
}
</style>
</head>
<body>
	<div class="otp-container">
		<div class="otp-card">
			<h2>Enter OTP</h2>
			<form action="/arise/register" method="post">
				<p>OTP sent to your registered email address</p>
				
				<div class="form-group">
					<input type="text" name="otp" placeholder="Enter 6-digit OTP" required maxlength="6" autocomplete="one-time-code" />
				</div>
				
				<c:if test="${param.error == 'otp-mismatch'}">
					<div class="error-msg">The OTP you entered is incorrect. Please try again.</div>
				</c:if>
				
				<button type="submit" class="btn-primary">Verify OTP</button>
			</form>

			<div class="actions">
				<form action="/arise/validation" method="POST" style="display: inline;">
					<button type="submit" class="btn-secondary">Resend OTP</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>