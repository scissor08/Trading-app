<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<title>Verify OTP</title>
<style>
:root {
	--background: #000;
	--card: #111;
	--highlight: #FFA500;
	--shadow: rgba(255, 165, 0, 0.2);
}

body {
	margin: 0;
	padding: 0;
	background-color: var(--background);
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	color: white;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.otp-card {
	background-color: var(--card);
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 4px 12px var(--shadow);
	text-align: center;
	width: 300px;
}

.otp-card h2 {
	margin-bottom: 20px;
	color: var(--highlight);
}

input[type="text"] {
	width: 100%;
	padding: 10px;
	border: 1px solid var(--highlight);
	border-radius: 5px;
	background-color: #222;
	color: white;
	margin-bottom: 20px;
}

input[type="submit"] {
	background-color: var(--highlight);
	color: #000;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-weight: bold;
}

input[type="submit"]:hover {
	background-color: #e69500;
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
	<div class="otp-card">
		<h2>Enter OTP</h2>
		<form action="/register" method="post">
			<p>OTP send to your Registered Mail id</p>
			<input type="text" name="otp" placeholder="Enter OTP" required />
			<c:if test="${param.error == 'otp-mismatch'}">
				<p class="error-msg">The OTP you entered is incorrect. Please try again.</p>
			</c:if>
			<input type="submit" value="Verify" />
		</form>

		<form action="/verification" method="POST" style="display: inline;">
		<button type="submit" style="background: none; border: none; color: var(--highlight); 
		text-decoration: none; cursor: pointer; margin-right: 10px;">Resend OTP</button>
		</form>
	</div>
</body>
</html>
