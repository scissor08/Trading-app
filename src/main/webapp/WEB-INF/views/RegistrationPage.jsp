<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Arize Registration</title>
<style>
/* [CSS remains unchanged] */
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
	padding: 1rem;
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
	margin-bottom: 0.3rem;
	font-weight: 600;
	color: #0e1c36;
}
form input {
	width: 100%;
	padding: 0.7rem 2.5rem 0.7rem 0.7rem;
	margin: 0;
	border: 1px solid #ccc;
	border-radius: 8px;
	outline: none;
	transition: border-color 0.3s;
	box-sizing: border-box;
}
form button {
	margin-top: 1rem;
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
form button:hover {
	background-color: #e66900;
}
.login-link {
	display: inline;
	margin-top: 1.5rem;
	margin-bottom: 0.5rem;
	margin-left: 1rem;
	text-align: center;
	color: #0e1c36;
	text-decoration: none;
	font-weight: bold;
}
.login-link:hover {
	color: #ff7f00;
}
.error-msg {
	color: red;
	margin-top: 0.5rem;
	font-size: 0.9rem;
	font-weight: bold;
}
</style>
</head>
<body>

<header>
	<h1>Arize Registration</h1>
	<a href="/" class="home-btn">Home</a>
</header>

<main>
	<form action="/validation" method="post" novalidate onsubmit="return validateForm();">

		<label for="name">Name</label>
		<input type="text" id="name" name="name"  value="${user.name}" required/>

		<label for="username">User Name</label>
		<input type="text" id="username" name="username"  value="${user.username}" required/>
		<c:if test="${param.error == 'username'}">
			<p class="error-msg">Username already exists!</p>
		</c:if>

		<label for="email">E-mail</label>
		<input type="email" id="email" name="email" value="${user.email}" required/>
		<c:if test="${param.error == 'email'}">
			<p class="error-msg">Email already exists!</p>
		</c:if>

		<label for="mobile">Mobile No</label>
		<input type="tel" id="mobile" name="mobile" value="${user.mobile}" required/>
		<c:if test="${param.error == 'mobile'}">
			<p class="error-msg">Mobile number already exists!</p>
		</c:if>

		<label for="password">Create Password</label>
		<input type="password" id="password" name="password" value="${user.password}" required/>

		<label for="cpass">Confirm Password</label>
		<input type="password" id="cpass" name="cpass" value="${user.cpass}" required/>

		<label for="pan">PAN Number</label>
		<input type="text" id="pan" name="pan" value="${user.pan}" required/>
		<c:if test="${param.error == 'pan'}">
			<p class="error-msg">PAN already exists!</p>
		</c:if>

		<label for="dateOfBirth">Enter DOB</label>
		<input type="date" id="dateOfBirth" name="dateOfBirth" value="${user.dateOfBirth}" required/>

		<p>Already have an Account? <a href="/login" class="login-link">Login Here</a></p>

		<button type="submit">Register</button>
	</form>
</main>

<script>
// [Validation JS remains unchanged]
function validateForm() {
    const name = document.getElementById("name").value.trim();
    const email = document.getElementById("email").value.trim();
    const mobile = document.getElementById("mobile").value.trim();
    const password = document.getElementById("password").value;
    const cpass = document.getElementById("cpass").value;
    const pan = document.getElementById("pan").value.trim();
    const dob = new Date(document.getElementById("dateOfBirth").value);
    const today = new Date();
    const age = today.getFullYear() - dob.getFullYear();
    const m = today.getMonth() - dob.getMonth();

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

    const panRegex = /^[A-Z]{5}[0-9]{4}[A-Z]$/i;
    if (!panRegex.test(pan)) {
        alert("PAN must be 10 characters: 5 letters, 4 digits, and 1 letter (e.g., ABCDE1234F).");
        return false;
    }

    const actualAge = (m < 0 || (m === 0 && today.getDate() < dob.getDate())) ? age - 1 : age;
    if (actualAge < 18) {
        alert("You must be at least 18 years old to register.");
        return false;
    }

    return true;
}
</script>

</body>
</html>
