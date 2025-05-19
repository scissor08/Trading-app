<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Arize Registration Page</title>
<style>
    :root {
        --black: #0d0d0d;
        --orange: #ff6600;
        --dark-grey: #1a1a1a;
        --input-bg: #333;
        --text: #fff;
        --hover: #ff8533;
    }
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
    }
    body {
        background-color: var(--black);
        color: var(--text);
        height: 100vh;
    }
    header {
        height: 20%;
        background-color: var(--dark-grey);
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 10px var(--orange);
    }
    header h1 {
        color: var(--orange);
        font-size: 32px;
    }
    main {
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
    }
    form {
        background-color: var(--dark-grey);
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 15px var(--orange);
        width: 100%;
        max-width: 500px;
    }
    label {
        display: block;
        margin-top: 15px;
        font-size: 16px;
        color: var(--orange);
    }
    input {
        width: 100%;
        padding: 10px;
        margin-top: 5px;
        border: none;
        border-radius: 5px;
        background-color: var(--input-bg);
        color: var(--text);
        font-size: 16px;
    }
    input:focus {
        outline: 2px solid var(--orange);
    }
    button {
        width: 100%;
        margin-top: 25px;
        padding: 12px;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        background-color: var(--orange);
        color: var(--black);
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    button:hover {
        background-color: var(--hover);
    }
</style>
</head>
<body>
<header>
    <h1>Arize New Account Registration</h1>
</header>
<main>
    <form action="/user/register" method="post">
        <label for="username">User Name</label>
        <input type="text" id="username" name="username" required>

        <label for="email">E-mail</label>
        <input type="email" id="email" name="email" required>

        <label for="mobile">Mobile No</label>
        <input type="tel" id="mobile" name="mobile" pattern="[6-9][0-9]{9}" required>

        <label for="password">Create Password</label>
        <input type="password" id="password" name="password" required>

        <label for="cpass">Confirm Password</label>
        <input type="password" id="cpass" name="cpass" required>

        <label for="pan">PAN Number</label>
        <input type="text" id="pan" name="pan" required>

        <label for="dateOfBirth">Enter DOB</label>
        <input type="date" id="dateOfBirth" name="dateOfBirth" required>

        <button type="submit">Register</button>
    </form>
</main>

<script>
document.querySelector("form").addEventListener("submit", function (e) {
    let username = document.querySelector('#username').value.trim();
    let email = document.querySelector('#email').value.trim();
    let mobile = document.querySelector('#mobile').value.trim();
    let password = document.querySelector('#password').value;
    let cpass = document.querySelector('#cpass').value;
    let panInput = document.querySelector('#pan');
    let pan = panInput.value.trim().toUpperCase();
    panInput.value = pan;  // update input to uppercase
    let dob = document.querySelector('#dateOfBirth').value;

    if (username === "") {
        alert("Username cannot be blank.");
        e.preventDefault();
        return;
    }

    if (!email.endsWith(".com")) {
        alert("Email must end with .com");
        e.preventDefault();
        return;
    }

    const mobileRegex = /^[6-9]\d{9}$/;
    if (!mobileRegex.test(mobile)) {
        alert("Mobile number must be 10 digits, start with 6-9 and contain only numbers.");
        e.preventDefault();
        return;
    }

    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@.,*&$/])[A-Za-z\d@.,*&$/]{8,}$/;
    if (!passwordRegex.test(password)) {
        alert("Password must be at least 8 characters long and include uppercase, lowercase, number, and symbol.");
        e.preventDefault();
        return;
    }

    if (password !== cpass) {
        alert("Confirm password must match the password.");
        e.preventDefault();
        return;
    }

    const panRegex = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
    if (!panRegex.test(pan)) {
        alert("PAN must be 10 characters: first 5 letters, next 4 digits, and last letter in uppercase.");
        e.preventDefault();
        return;
    }

    const dobDate = new Date(dob);
    const today = new Date();
    const minDate = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());

    if (dobDate > minDate) {
        alert("You must be at least 18 years old.");
        e.preventDefault();
        return;
    }
});
</script>
</body>
</html>
