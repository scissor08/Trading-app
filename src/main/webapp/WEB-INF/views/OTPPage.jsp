<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        .error, .message {
            margin-top: 10px;
            font-size: 14px;
        }

        .error {
            color: red;
        }

        .message {
            color: lightgreen;
        }
    </style>
</head>
<body>
<div class="otp-card">
    <h2>Enter OTP</h2>
    <form action="/register" method="post">
        <input type="text" name="otp" placeholder="Enter OTP" required />
        <input type="submit" value="Verify" />
    </form>

    <div class="error">${error}</div>
    <div class="message">${message}</div>
    <div style="margin-top: 15px;">
    <a href="/verification" style="color: var(--highlight); text-decoration: none; margin-right: 10px;">Resend OTP</a>
	</div>
</div>
</body>
</html>
