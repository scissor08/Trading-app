<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>

    <!-- ✅ Bootstrap & Chart.js -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body { background-color: #f5f5f5; }
        .icon-btn { font-size: 24px; margin: 0 10px; }
        .wallet-info { margin-top: 10px; }
        .stock-card {
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 10px;
            margin: 10px;
            box-shadow: 2px 2px 5px rgba(0,0,0,0.1);
        }
        .table-container { margin-top: 20px; }
        footer {
            text-align: center;
            margin-top: 50px;
            padding: 20px;
            background-color: #222;
            color: white;
        }
    </style>
</head>
<body>
<div class="container mt-4">

    <!-- Header -->
    <header class="d-flex justify-content-between align-items-center mb-4">
        <form class="d-flex" action="/user/search" method="get">
            <input class="form-control me-2" type="text" name="query" placeholder="Search">
            <button class="btn btn-primary" type="submit">Search</button>
        </form>

        <div>
            <span class="me-3 fw-bold fs-4">Welcome, ${username}</span>
            <a href="${pageContext.request.contextPath}/user/profile" class="icon-btn text-dark" title="Profile">
                <i class="fas fa-user-circle"></i>
            </a>
            <a href="${pageContext.request.contextPath}/user/logout" class="icon-btn text-danger" title="Logout">
                <i class="fas fa-sign-out-alt"></i>
            </a>
        </div>
    </header>

    <!-- Wallet -->
    <div class="alert alert-secondary d-flex justify-content-between align-items-center">
        <div>
            <h5 class="mb-1">Wallet Balance: ₹${balance}</h5>
            <a href="/user/addbalance" class="btn btn-sm btn-outline-success">Add Balance</a>
        </div>
    </div>

    <!-- Navigation -->
    <nav class="mb-4">
        <ul class="nav nav-pills">
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
            <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/portfolio">Portfolio</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/stocks">Stocks</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/trades">Buy/Sell</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/transactions">Transaction</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/wallet">Wallet</a></li>
        </ul>
    </nav>

    <!-- Market Highlights -->
    <h3>Market Highlights</h3>
    <div class="row">
        <c:forEach var="stock" items="${stocks}">
            <div class="col-md-3">
                <div class="stock-card">
                    <h5>${stock.symbol}</h5>
                    <p><strong>High:</strong> ${stock.high}</p>
                    <p><strong>Low:</strong> ${stock.low}</p>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Stock Overview Table -->
    <h3 class="mt-5">Stock Overview Table</h3>
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>Symbol</th>
                    <th>High</th>
                    <th>Low</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="stock" items="${stocks}">
                    <tr>
                        <td>${stock.symbol}</td>
                        <td>${stock.high}</td>
                        <td>${stock.low}</td>
                         <td>${stock.price}</td>
                          <td>${stock.domain}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Chart -->
    <h3 class="mt-5">Stock Price Comparison</h3>
    <canvas id="stockChart" height="120"></canvas>

    <!-- Footer -->
    <footer>
        &copy; 2025 Trading App | All rights reserved
    </footer>
</div>

<!-- Chart Script -->
<script>
const stockSymbols = [<c:forEach var="s" items="${stocks}" varStatus="status">'${s.symbol}'<c:if test="${!status.last}">,</c:if></c:forEach>];
const stockHighs = [<c:forEach var="s" items="${stocks}" varStatus="status">${s.high}<c:if test="${!status.last}">,</c:if></c:forEach>];
const stockLows = [<c:forEach var="s" items="${stocks}" varStatus="status">${s.low}<c:if test="${!status.last}">,</c:if></c:forEach>];

const ctx = document.getElementById('stockChart').getContext('2d');
new Chart(ctx, {
    type: 'bar',
    data: {
        labels: stockSymbols,
        datasets: [
            {
                label: 'High Price',
                backgroundColor: 'orange',
                data: stockHighs
            },
            {
                label: 'Low Price',
                backgroundColor: 'grey',
                data: stockLows
            }
        ]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                labels: { color: '#333' }
            }
        },
        scales: {
            x: { ticks: { color: '#333' } },
            y: { ticks: { color: '#333' } }
        }
    }
});
</script>
</body>
</html>
