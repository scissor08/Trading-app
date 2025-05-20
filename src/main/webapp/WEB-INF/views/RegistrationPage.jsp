<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Arize Registration</title>
<style>
/* (Your existing styles unchanged) */
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
    margin-bottom: 0.3rem; /* Add a small margin below label */
    font-weight: 600;
    color: #0e1c36;
}

form input {
    width: 100%;
    padding: 0.7rem 2.5rem 0.7rem 0.7rem; /* add right padding for icon space */
    margin: 0; /* remove margin */
    border: 1px solid #ccc;
    border-radius: 8px;
    outline: none;
    transition: border-color 0.3s;
    box-sizing: border-box; /* ensure padding included in width */
}

.password-wrapper {
    position: relative;
}

.password-wrapper input {
    padding-right: 2.5rem; /* space for toggle icon */
}

.password-wrapper .toggle-password {
    position: absolute;
    top: 50%;
    right: 0.7rem; /* align toggle icon */
    transform: translateY(-50%);
    cursor: pointer;
    fill: #ff7f00;
    width: 20px;
    height: 20px;
    user-select: none;
}

form button {
    margin-top: 2rem;
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

</style>
</head>
<body>
<header>
	<h1>Arize Registration</h1>
	<a href="/" class="home-btn">Home</a>
</header>

<main>
	<form action="/user/register" method="post" novalidate>
		<label for="username">User Name</label>
		<input type="text" id="username" name="username" required />

		<label for="email">E-mail</label>
		<input type="email" id="email" name="email" required />

		<label for="mobile">Mobile No</label>
		<input type="tel" id="mobile" name="mobile" pattern="[6-9][0-9]{9}" required />

		<label for="password">Create Password</label>
		<div class="password-wrapper">
			<input type="password" id="password" name="password" required />
			<span class="toggle-password" role="button" aria-label="Toggle Password Visibility" tabindex="0">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 5c-7 0-11 7-11 7s4 7 11 7 11-7 11-7-4-7-11-7zm0 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10zm0-8a3 3 0 1 0 0 6 3 3 0 0 0 0-6z"/></svg>
			</span>
		</div>

		<label for="cpass">Confirm Password</label>
		<div class="password-wrapper">
			<input type="password" id="cpass" name="cpass" required />
			<span class="toggle-password" role="button" aria-label="Toggle Password Visibility" tabindex="0">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 5c-7 0-11 7-11 7s4 7 11 7 11-7 11-7-4-7-11-7zm0 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10zm0-8a3 3 0 1 0 0 6 3 3 0 0 0 0-6z"/></svg>
			</span>
		</div>

		<label for="pan">PAN Number</label>
		<input type="text" id="pan" name="pan" required />

		<label for="dateOfBirth">Enter DOB</label>
		<input type="date" id="dateOfBirth" name="dateOfBirth" required />

		<button type="submit">Register</button>
	</form>
</main>

<script>
document.addEventListener('DOMContentLoaded', () => {
	const toggles = document.querySelectorAll('.toggle-password');
	toggles.forEach(toggle => {
		toggle.addEventListener('click', () => {
			const input = toggle.previousElementSibling;
			if (input.type === 'password') {
				input.type = 'text';
				toggle.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7zm10-3a3 3 0 1 1 0 6 3 3 0 0 1 0-6z" fill="#ff7f00"/></svg>`;
			} else {
				input.type = 'password';
				toggle.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12 5c-7 0-11 7-11 7s4 7 11 7 11-7 11-7-4-7-11-7zm0 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10zm0-8a3 3 0 1 0 0 6 3 3 0 0 0 0-6z"/></svg>`;
			}
		});
	});
});
</script>
</body>
</html>
