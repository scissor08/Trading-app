<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Success!</title>
  <style>
    body {
      background-color: #f5f7fa;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .success-container {
      background-color: #ffffff;
      border-left: 6px solid #28a745;
      padding: 40px 50px;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      text-align: center;
      max-width: 450px;
    }

    .success-container h1 {
      color: #28a745;
      font-size: 2.4rem;
      margin-bottom: 15px;
    }

    .success-container p {
      color: #0e1c36;
      font-size: 1.1rem;
      margin-bottom: 30px;
    }

    .btn-home {
      background-color: #28a745;
      color: white;
      text-decoration: none;
      padding: 12px 28px;
      border-radius: 8px;
      font-weight: bold;
      font-size: 1rem;
      transition: background-color 0.3s ease;
    }

    .btn-home:hover {
      background-color: #218838;
    }
  </style>
</head>
<body>
  <div class="success-container">
    <h1>${message}</h1>
    <p>Your registration was completed successfully.</p>
    <a href="${pageContext.request.contextPath}/user/loginpage" class="btn-home">Go to Login</a>
  </div>
</body>
</html>
