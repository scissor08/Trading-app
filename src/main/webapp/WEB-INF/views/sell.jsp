<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sell Stock - Trading Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #0d1b2a;
            color: white;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .sidebar {
            background-color: #1b263b;
            min-height: 100vh;
            padding: 20px;
            color: #ffffff;
        }
        .main-content {
            padding: 40px;
        }
        .header {
            margin-bottom: 30px;
            border-bottom: 1px solid #415a77;
            padding-bottom: 20px;
        }
        .btn-sell {
            background-color: #00ffd5;
            border: none;
            color: #000;
            font-weight: bold;
            transition: 0.3s;
        }
        .btn-sell:hover {
            background-color: #009688;
            color: white;
        }
        .message {
            padding: 15px;
            border-radius: 8px;
        }
        .error {
            background-color: #dc3545;
        }
        .animation-container {
            text-align: center;
            padding: 30px 0;
            animation: glowPulse 6s infinite ease-in-out;
        }
        .animation-container img {
            width: 85%;
            max-width: 600px;
            border-radius: 18px;
            box-shadow: 0 0 35px #00ffc3, 0 0 60px #00bfff;
            animation: floaty 4s ease-in-out infinite;
        }
        @keyframes floaty {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        @keyframes glowPulse {
            0%, 100% { background-color: transparent; }
            50% { background-color: rgba(0, 255, 200, 0.03); }
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 sidebar">
            <h3>📈 Trading Dashboard</h3>
            <ul class="nav flex-column mt-4">
                <li class="nav-item"><a class="nav-link text-white" href="#">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="#">Portfolio</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="#">Transactions</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="#">Market</a></li>
            </ul>
            <hr>
            <button class="btn btn-sell mt-3" data-bs-toggle="modal" data-bs-target="#sellModal">💸 Sell Stock</button>
        </div>

        <!-- Main Content -->
        <div class="col-md-9 main-content">
            <div class="header">
                <h2>Sell Your Stocks</h2>
                <p>Trade smart. Track real-time balance and stock summary.</p>
            </div>

            <div class="animation-container">
                <img src="https://media.giphy.com/media/xT0BKqhdlKCxCNsVTq/giphy.gif" alt="Neon Stock Market Animation" />
            </div>

            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>
        </div>
    </div>
</div>

<!-- Sell Modal -->
<div class="modal fade" id="sellModal" tabindex="-1" aria-labelledby="sellModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form method="post" action="sell">
            <div class="modal-content bg-dark text-white">
                <div class="modal-header">
                    <h5 class="modal-title" id="sellModalLabel">Sell Stock</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="userId" value="1" />
                    <div class="mb-3">
                        <label class="form-label">Stock Symbol</label>
                        <input type="text" class="form-control" name="symbol" required />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Quantity</label>
                        <input type="number" class="form-control" name="quantity" min="1" required />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-sell">Confirm Sell</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
