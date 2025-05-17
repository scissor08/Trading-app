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
      background-color: #e6f7e6;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .success-container {
      background-color: #d4edda;
      border: 2px solid #28a745;
      padding: 40px 60px;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(40, 167, 69, 0.4);
      text-align: center;
      max-width: 400px;
    }

    .success-container h1 {
      color: #155724;
      font-size: 2.5rem;
      margin-bottom: 10px;
    }

    .success-container p {
      color: #155724;
      font-size: 1.2rem;
      margin-bottom: 25px;
    }

    .success-container .btn-home {
      background-color: #28a745;
      color: white;
      text-decoration: none;
      padding: 12px 25px;
      border-radius: 6px;
      font-weight: 600;
      font-size: 1rem;
      transition: background-color 0.3s ease;
      display: inline-block;
    }

    .success-container .btn-home:hover {
      background-color: #218838;
    }
  </style>
</head>
<body>
  <div class="success-container">
    <h1>${message}</h1>
    <p>Your registration was completed successfully.</p>
    <a href="/user/loginpage" class="btn-home">Login</a>
  </div>
</body>
</html>
