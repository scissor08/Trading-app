<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<style>
body {
	margin: 0;
	padding: 0;
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f5f7fa;
	color: #0e1c36;
}

header {
	background-color: #0e1c36;
	padding: 1rem 2rem;
	color: #ffffff;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

header h1 {
	margin: 0;
	font-size: 1.5rem;
}

.home-btn {
	background-color: #ffffff;
	color: #0e1c36;
	padding: 0.5rem 1rem;
	border: none;
	border-radius: 8px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.3s, color 0.3s;
	text-decoration: none;
}

.home-btn:hover {
	background-color: #ff7f00;
	color: #ffffff;
}

main {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 90vh;
}

form {
	background-color: #ffffff;
	color: #0e1c36;
	padding: 2rem 3rem;
	border-radius: 12px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 400px;
}

form label {
	display: block;
	margin-top: 1rem;
	font-weight: 600;
	color: #0e1c36;
}

form input {
	width: 100%;
	padding: 0.7rem;
	margin-top: 0.3rem;
	border: 1px solid #ccc;
	border-radius: 8px;
	outline: none;
	transition: border-color 0.3s;
}

form input:focus {
	border-color: #ff7f00;
}

.password-wrapper {
	position: relative;
}

.password-wrapper input {
	padding-right: 0.7rem;
}

button {
	margin-top: 1.5rem;
	width: 100%;
	padding: 0.8rem;
	background-color: #ff7f00;
	color: white;
	font-size: 1rem;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s;
}

button:hover {
	background-color: #e66900;
}

.links {
	text-align: center;
	margin-top: 1rem;
}

.links a {
	color: #0e1c36;
	text-decoration: none;
	display: inline-block;
	margin: 5px 0;
}

.links a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<header>
		<h1>Arize - Login</h1>
		<a href="/" class="home-btn">Home</a>
	</header>
	<main>
		<section>
			<form action="/login" method="post">
    <label for="username">User name</label> 
    <input type="text" name="username" required> 
    
    <label for="password">Password</label>
    <div class="password-wrapper">
        <input type="password" name="password" id="password" required>
    </div>
    
    <c:if test="${sessionScope.ATTEMPTS >= 2}">
        <div class="g-recaptcha" data-sitekey="6Ldl-VArAAAAAAlU_PMEXmBCzeF8Go5E3EvSpWHV"></div>
    </c:if>
    
    <!-- Error Messages -->
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
        <a href="/forget">Forgot Password?</a><br>
        <span>Don't have an account? <a href="/registration">Register here</a></span>
    </div>
</form>
		</section>
	</main>

	<script>
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
		
	</script>
</body>
</html>

