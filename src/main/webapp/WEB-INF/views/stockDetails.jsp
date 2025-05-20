<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Stock Details - ${stock.symbol}</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            color: #0e1c36;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #0e1c36;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            text-align: left;
            padding: 10px 12px;
            border-bottom: 1px solid #ccc;
        }

        th {
            width: 200px;
            color: #0e1c36;
        }

        td a {
            color: #ff7f00;
            text-decoration: underline;
        }

        img {
            display: block;
            margin: 30px auto;
            border-radius: 8px;
        }

        .buttons {
            text-align: center;
            margin: 30px 0;
        }

        .buttons button {
            padding: 10px 25px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin: 0 15px;
            transition: background-color 0.3s;
        }

        .buttons form {
            display: inline-block;
        }

        .buy-button {
            background-color: #28a745;
            color: white;
        }

        .buy-button:hover {
            background-color: #218838;
        }

        .sell-button {
            background-color: #dc3545;
            color: white;
        }

        .sell-button:hover {
            background-color: #c82333;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 40px;
            font-weight: bold;
            color: #ff7f00;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        #chartContainer {
            margin-top: 50px;
        }

        canvas {
            width: 100% !important;
            height: 400px !important;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Stock: ${stock.symbol}</h2>

    <table>
        <tr><th>Price:</th><td>${stock.price}</td></tr>
        <tr><th>Change:</th><td>${stock.change}</td></tr>
        <tr><th>Change Percent:</th><td>${stock.changePercent}</td></tr>
        <tr><th>Open:</th><td>${stock.open}</td></tr>
        <tr><th>High:</th><td>${stock.high}</td></tr>
        <tr><th>Low:</th><td>${stock.low}</td></tr>
        <tr><th>Previous Close:</th><td>${stock.previousClose}</td></tr>
        <tr><th>Latest Trading Day:</th><td>${stock.latestTradingDay}</td></tr>
        <tr>
            <th>Company Domain:</th>
            <td>
                <c:if test="${stock.domain != null && !stock.domain.isEmpty()}">
                    <a href="https://${stock.domain}" target="_blank">${stock.domain}</a>
                </c:if>
            </td>
        </tr>
    </table>

    <c:if test="${stock.domain != null && !stock.domain.isEmpty()}">
        <img src="https://logo.clearbit.com/${stock.domain}" alt="${stock.symbol} logo" width="100" />
    </c:if>

    <div class="buttons">
        <form action="/buyStock" method="post">
            <input type="hidden" name="symbol" value="${stock.symbol}" />
            <button type="submit" class="buy-button">Buy</button>
        </form>
        <form action="/sellStock" method="post">
            <input type="hidden" name="symbol" value="${stock.symbol}" />
            <button type="submit" class="sell-button">Sell</button>
        </form>
    </div>

    <div id="chartContainer">
        <canvas id="priceChart"></canvas>
    </div>

    <a href="${pageContext.request.contextPath}/stocks" class="back-link">← Back to All Stocks</a>
</div>

<script>
    const labels = ['2025-05-10', '2025-05-11', '2025-05-12', '2025-05-13', '2025-05-14', '2025-05-15', '2025-05-16'];
    const prices = [335, 338, 340, 337, 339, 341, parseFloat('${stock.price}')];

    const ctx = document.getElementById('priceChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '${stock.symbol} Price',
                data: prices,
                borderColor: '#ff7f00',
                backgroundColor: 'rgba(255, 127, 0, 0.2)',
                fill: true,
                tension: 0.2,
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            scales: {
                x: {
                    ticks: { color: '#0e1c36' },
                    grid: { color: '#ccc' }
                },
                y: {
                    ticks: { color: '#0e1c36' },
                    grid: { color: '#ccc' },
                    beginAtZero: false
                }
            },
            plugins: {
                legend: {
                    labels: { color: '#0e1c36' }
                }
            },
            responsive: true,
            maintainAspectRatio: false
        }
    });
</script>

</body>
</html>
