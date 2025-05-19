<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Stock Details - ${stock.symbol}</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background-color: black;
            color: orange;
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            border: 2px solid orange;
            padding: 30px;
            border-radius: 10px;
            background-color: #111;
            text-align: center;
        }
        .field {
            font-weight: bold;
            margin: 8px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            text-align: left;
            padding: 10px;
            border-bottom: 1px solid orange;
        }
        img {
            margin: 20px 0;
            border-radius: 8px;
        }
        .buttons {
            margin-top: 20px;
        }
        button {
            background-color: orange;
            color: black;
            font-weight: bold;
            border: none;
            padding: 10px 20px;
            margin: 0 10px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #ffb84d;
        }
        #chartContainer {
            margin-top: 40px;
        }
        a {
            color: orange;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .back-link {
            margin-top: 30px;
            display: block;
            text-align: center;
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
        <form action="/buyStock" method="post" style="display:inline;">
            <input type="hidden" name="symbol" value="${stock.symbol}" />
            <button type="submit">Buy</button>
        </form>
        <form action="/sellStock" method="post" style="display:inline;">
            <input type="hidden" name="symbol" value="${stock.symbol}" />
            <button type="submit">Sell</button>
        </form>
    </div>

    <div id="chartContainer">
        <canvas id="priceChart" width="600" height="300"></canvas>
    </div>

    <a href="${pageContext.request.contextPath}/stocks" class="back-link">← Back to All Stocks</a>
</div>

<script>
    // Mocked chart data — replace with actual data
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
                borderColor: 'orange',
                backgroundColor: 'rgba(255, 165, 0, 0.2)',
                fill: true,
                tension: 0.2,
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            scales: {
                x: {
                    ticks: { color: 'orange' },
                    grid: { color: '#333' }
                },
                y: {
                    ticks: { color: 'orange' },
                    grid: { color: '#333' },
                    beginAtZero: false
                }
            },
            plugins: {
                legend: {
                    labels: { color: 'orange' }
                }
            },
            responsive: true,
            maintainAspectRatio: false
        }
    });
</script>

</body>
</html>
