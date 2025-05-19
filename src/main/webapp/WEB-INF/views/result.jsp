<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Stock Result - ${stock.symbol}</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background-color: #000;
            color: orange;
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 50px;
        }
        .stock-container {
            display: inline-block;
            border: 2px solid orange;
            padding: 30px;
            border-radius: 10px;
            background-color: #111;
            max-width: 600px;
            margin: auto;
        }
        img {
            margin-top: 20px;
            border-radius: 8px;
        }
        .field {
            font-weight: bold;
            margin: 8px 0;
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
    </style>
</head>
<body>
    <div class="stock-container">
        <h1>Stock: ${stock.symbol}</h1>
        <div class="field">Price: ${stock.price}</div>
        <div class="field">Open: ${stock.open}</div>
        <div class="field">High: ${stock.high}</div>
        <div class="field">Low: ${stock.low}</div>
        <div class="field">Previous Close: ${stock.previousClose}</div>

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
    </div>

    <script>
        // Sample data for demo - replace this with real historical data from your backend or API
        const labels = [
            '2025-05-10', '2025-05-11', '2025-05-12', '2025-05-13', '2025-05-14', '2025-05-15', '2025-05-16'
        ];
        const prices = [335, 338, 340, 337, 339, 341, parseFloat('${stock.price}')];

        const ctx = document.getElementById('priceChart').getContext('2d');
        const priceChart = new Chart(ctx, {
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
                    pointHoverRadius: 6,
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
                maintainAspectRatio: false,
            }
        });
    </script>
</body>
</html>
