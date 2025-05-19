<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Page</title>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f7f9;
    }

    header {
        background-color: #0e1c36;
        padding: 1rem 2rem;
        color: white;
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
        transition: background-color 0.3s;
        text-decoration: none;
    }

    .home-btn:hover {
        background-color: #d6e0f0;
    }

    main {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 90vh;
    }

    form {
        background-color: white;
        padding: 2rem 3rem;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 500px;
    }

    form label {
        display: block;
        margin-top: 1rem;
        font-weight: 600;
        color: #333;
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
        border-color: #007bff;
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
        background-color: #007bff;
        color: white;
        font-size: 1rem;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    button:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>

    <header>
        <h1>Trading App - User Registration</h1>
        <a href="/" class="home-btn">Home</a>
    </header>

    <main>
        <section>
            <form action="/user/register" method="post">
                <label for="username">User name</label>
                <input type="text" name="username" required>

                <label for="email">E-mail</label>
                <input type="email" name="email" required>

                <label for="mobile">Mobile No</label>
                <input type="text" name="mobile" required>

                <label for="password">Create Password</label>
                <div class="password-wrapper">
                    <input type="password" name="password" id="password" required>
                </div>

                <label for="cpass">Confirm Password</label>
                <div class="password-wrapper">
                    <input type="password" name="cpass" id="cpass" required>
                </div>

                <label for="pan">PAN Number</label>
                <input type="text" name="pan" required>

                <label for="dateOfBirth">Enter DOB</label>
                <input type="date" name="dateOfBirth" required>

                <button>Register</button>
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

    document.querySelector("form").addEventListener("submit", function (e) {
        const username = document.querySelector('input[name="username"]').value.trim();
        const email = document.querySelector('input[name="email"]').value.trim();
        const mobile = document.querySelector('input[name="mobile"]').value.trim();
        const password = document.querySelector('input[name="password"]').value;
        const cpass = document.querySelector('input[name="cpass"]').value;
        const pan = document.querySelector('input[name="pan"]').value.trim();
        const panInput = document.querySelector('input[name="pan"]');
        pan = panInput.value.trim().toUpperCase();
        panInput.value = pan;
        console.log(pan);
        const dob = document.querySelector('input[name="dateOfBirth"]').value;

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

        const panRegex = /^[A-Z][a-z]{5}[0-9]{4}[A-Z]{1}$/;
        if (!panRegex.test(pan)) {
            alert("PAN must be 10 characters: first 5 letters, next 4 digits, and last letter in uppercase.");
            e.preventDefault();
            return pan;
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
