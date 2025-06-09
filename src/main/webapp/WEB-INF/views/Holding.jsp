<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Holdings - StockTrader</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: white;
    color: #333;
    line-height: 1.6;
}

/* Navigation Bar */
.navbar {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    padding: 1rem 2rem;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
}

.navbar-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1400px;
    margin: 0 auto;
}

.navbar-brand {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: white;
    font-size: 1.5rem;
    font-weight: 700;
    text-decoration: none;
}

.navbar-brand i {
    font-size: 1.8rem;
    color: #00ff88;
}

.navbar-nav {
    display: flex;
    gap: 2rem;
    align-items: center;
}

.nav-item {
    color: white;
    text-decoration: none;
    font-weight: 500;
    padding: 0.5rem 1rem;
    border-radius: 8px;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.nav-item:hover {
    background: rgba(255, 255, 255, 0.1);
    color: #00ff88;
    transform: translateY(-2px);
}

.nav-item.active {
    background: rgba(255, 255, 255, 0.2);
    color: #00ff88;
}

.nav-search {
    display: flex;
    align-items: center;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 25px;
    padding: 0.5rem 1rem;
    gap: 0.5rem;
}

.nav-search input {
    background: transparent;
    border: none;
    outline: none;
    color: white;
    width: 200px;
}

.nav-search input::placeholder {
    color: rgba(255, 255, 255, 0.7);
}

.nav-search i {
    color: rgba(255, 255, 255, 0.7);
}

.user-profile {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    cursor: pointer;
    transition: all 0.3s ease;
}

.user-profile:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: scale(1.1);
}

/* Main Content */
.main-content {
    margin-top: 20px;
    padding: 2rem;
    background: white;
    min-height: calc(100vh - 100px);
}

.page-header {
    text-align: center;
    margin-bottom: 3rem;
}

.page-title {
    font-size: 2.5rem;
    font-weight: 700;
    color: #333;
    margin-bottom: 0.5rem;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.page-subtitle {
    font-size: 1.1rem;
    color: #666;
    font-weight: 400;
}

/* 3D Table Container */
.table-3d-container {
    max-width: 1400px;
    margin: 0 auto;
    perspective: 1000px;
}

.holdings-table-wrapper {
    background: white;
    border-radius: 20px;
    box-shadow: 
        0 20px 40px rgba(0, 0, 0, 0.1),
        0 0 0 1px rgba(255, 255, 255, 0.1);
    overflow: hidden;
    transform-style: preserve-3d;
    transition: all 0.3s ease;
    border: 1px solid #e0e0e0;
}

.holdings-table-wrapper:hover {
    transform: rotateX(2deg) rotateY(-2deg);
    box-shadow: 
        0 30px 60px rgba(0, 0, 0, 0.15),
        0 0 0 1px rgba(255, 255, 255, 0.1);
}

.table-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 1.5rem 2rem;
    display: flex;
    align-items: center;
    gap: 1rem;
    position: relative;
}

.table-header::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 3px;
    background: linear-gradient(90deg, #00ff88, #00d4ff, #ff0080);
}

.table-header h3 {
    margin: 0;
    font-size: 1.4rem;
    font-weight: 600;
}

.table-header i {
    font-size: 1.5rem;
    color: #00ff88;
}

/* 3D Table Styles */
.holdings-table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    position: relative;
}

.holdings-table thead {
    background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
    position: relative;
}

.holdings-table thead::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 2px;
    background: linear-gradient(90deg, #667eea, #764ba2);
}

.holdings-table th {
    padding: 1.5rem 1rem;
    color: white;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.9rem;
    letter-spacing: 1px;
    text-align: center;
    position: relative;
    border-right: 1px solid rgba(255, 255, 255, 0.1);
}

.holdings-table th:first-child {
    text-align: left;
    padding-left: 2rem;
}

.holdings-table th:last-child {
    border-right: none;
    padding-right: 2rem;
}

.holdings-table th i {
    margin-right: 0.5rem;
    color: #00ff88;
}

.holdings-table td {
    padding: 1.5rem 1rem;
    border-bottom: 1px solid #f0f0f0;
    text-align: center;
    font-weight: 500;
    transition: all 0.3s ease;
    position: relative;
    background: white;
}

.holdings-table td:first-child {
    text-align: left;
    padding-left: 2rem;
    font-weight: 700;
    color: #2c3e50;
    font-size: 1.1rem;
}

.holdings-table td:last-child {
    padding-right: 2rem;
}

.holdings-table tbody tr {
    transition: all 0.3s ease;
    position: relative;
}

.holdings-table tbody tr:hover {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    transform: translateZ(10px) scale(1.02);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    border-left: 4px solid #667eea;
}

.holdings-table tbody tr:hover td {
    background: transparent;
}

/* Profit/Loss Styling */
.profit-positive {
    color: #27ae60;
    font-weight: 700;
    background: linear-gradient(135deg, #2ecc71, #27ae60);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
}

.profit-negative {
    color: #e74c3c;
    font-weight: 700;
    background: linear-gradient(135deg, #e74c3c, #c0392b);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
}

.currency {
    font-size: 0.9rem;
    opacity: 0.8;
    margin-right: 0.2rem;
}

/* Empty State */
.empty-state {
    text-align: center;
    padding: 4rem 2rem;
    color: #666;
}

.empty-state i {
    font-size: 4rem;
    margin-bottom: 1rem;
    opacity: 0.3;
    color: #667eea;
}

.empty-state h3 {
    margin-bottom: 0.5rem;
    color: #333;
}

/* Responsive Design */
@media (max-width: 768px) {
    .navbar-content {
        flex-direction: column;
        gap: 1rem;
    }

    .navbar-nav {
        gap: 1rem;
    }

    .nav-search {
        order: -1;
        width: 100%;
    }

    .nav-search input {
        width: 100%;
    }

    .main-content {
        padding: 1rem;
        margin-top: 140px;
    }

    .page-title {
        font-size: 2rem;
    }

    .holdings-table th,
    .holdings-table td {
        padding: 1rem 0.5rem;
        font-size: 0.9rem;
    }

    .holdings-table th:first-child,
    .holdings-table td:first-child {
        padding-left: 1rem;
    }

    .holdings-table th:last-child,
    .holdings-table td:last-child {
        padding-right: 1rem;
    }

    .holdings-table-wrapper:hover {
        transform: none;
    }
}

@media (max-width: 480px) {
    .table-3d-container {
        margin: 0 -1rem;
    }

    .holdings-table {
        font-size: 0.8rem;
    }
}

/* Loading Animation */
@keyframes pulse {
    0%, 100% {
        opacity: 1;
    }
    50% {
        opacity: 0.5;
    }
}

.loading {
    animation: pulse 1.5s infinite;
}
</style>
</head>
<body>


<jsp:include page="header.jsp" />
<!-- Main Content -->
<main class="main-content">
    <div class="page-header">
        <h1 class="page-title">
            Your Holdings Portfolio
        </h1>
        <p class="page-subtitle">Track your investments and monitor real-time performance</p>
    </div>

    <div class="table-3d-container">
        <div class="holdings-table-wrapper">
            <div class="table-header">
                <i class="fas fa-briefcase"></i>
                <h3>Investment Holdings</h3>
            </div>
            
            <div style="overflow-x: auto;">
                <c:choose>
                    <c:when test="${not empty holdings}">
                        <table class="holdings-table" id="holdingsTable">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-tag"></i>Symbol</th>
                                    <th><i class="fas fa-layer-group"></i>Quantity</th>
                                    <th><i class="fas fa-dollar-sign"></i>Buy Price</th>
                                    <th><i class="fas fa-chart-line"></i>Current Price</th>
                                    <th><i class="fas fa-calculator"></i>Total Investment</th>
                                    <th><i class="fas fa-money-bill-wave"></i>Current Value</th>
                                    <th><i class="fas fa-balance-scale"></i>Profit / Loss</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="holding" items="${holdings}">
                                    <tr>
                                        <td><strong>${holding.symbol}</strong></td>
                                        <td>${holding.quantity}</td>
                                        <td><span class="currency">₹</span>${holding.price}</td>
                                        <td><span class="currency">₹</span>${holding.trancationAmount}</td>
                                     <td><span class="currency">₹</span><fmt:formatNumber value="${holding.quantity * holding.price}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>

                                        <td><span class="currency">₹</span>${holding.quantity * holding.trancationAmount}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${(holding.trancationAmount - holding.price) >= 0}">
                                                    <span class="profit-positive">
                                                        <i class="fas fa-arrow-up"></i>
                                                        +<span class="currency">₹</span>${((holding.trancationAmount - holding.price) * holding.quantity)}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="profit-negative">
                                                        <i class="fas fa-arrow-down"></i>
                                                        -<span class="currency">₹</span>${((holding.price - holding.trancationAmount) * holding.quantity)}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-chart-line"></i>
                            <h3>No Holdings Found</h3>
                            <p>Start investing to see your portfolio here</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</main>

<jsp:include page="footer.jsp" />

</body>
</html>