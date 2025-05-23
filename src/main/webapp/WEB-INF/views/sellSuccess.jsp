<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sell Successful</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #0d1b2a;
            color: #00ffd5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-align: center;
            padding-top: 50px;
        }
        .card {
            background-color: #1b263b;
            border: 1px solid #00ffd5;
            box-shadow: 0 0 20px #00ffd5;
            border-radius: 12px;
            padding: 30px;
            max-width: 500px;
            margin: auto;
        }
        .btn-dashboard {
            margin-top: 20px;
            background-color: #00ffd5;
            color: black;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="card">
    <h2>✅ Sell Successful!</h2>
    <p><strong>${response.message}</strong></p>
    <p>Transaction Amount: ₹${response.transactionAmount}</p>
    <p>Sold Quantity: ${response.quantity}</p>
    <p>Remaining Balance: ₹${response.remainingBalance}</p>

    <a href="dashboard" class="btn btn-dashboard">🔙 Back to Dashboard</a>
</div>

</body>
</html>
