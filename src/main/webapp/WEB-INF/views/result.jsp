<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Stock Result - ${stock.symbol}</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background-color: #f5f7fa;
            color: #0e1c36;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            text-align: center;
            padding-top: 50px;
        }

        .stock-container {
            display: inline-block;
            border: 2px solid #0e1c36;
            padding: 30px;
            border-radius: 12px;
            background-color: #ffffff;
            max-width: 650px;
            margin: auto;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        img {
            margin-top: 20px;
            border-radius: 8px;
            max-width: 100px;
        }

        .field {
            font-weight: bold;
            margin: 10px 0;
            font-size: 1.1rem;
        }

        .buttons {
            margin-top: 25px;
        }

        .buttons form {
            display: inline-block;
            margin: 0 10px;
        }

        button.buy-btn {
            background-color: #28a745;
            color: white;
            font-weight: 600;
            border: none;
            padding: 12px 28px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        button.buy-btn:hover {
            background-color: #218838;
        }

        button.sell-btn {
            background-color: #dc3545;
            color: white;
            font-weight: 600;
            border: none;
            padding: 12px 28px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        button.sell-btn:hover {
            background-color: #c82333;
        }

        #chartContainer {
            margin-top: 40px;
        }

        canvas {
            width: 100% !important;
            max-width: 600px;
            height: auto !important;
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
            <img src="https://logo.clearbit.com/${stock.domain}" alt="${stock.symbol} logo" />
        </c:if>

        <div class="buttons">
            <form action="/buyStock" method="post">
                <input type="hidden" name="symbol" value="${stock.symbol}" />
                <button type="submit" class="buy-btn">Buy</button>
            </form>
            <form action="/sellStock" method="post">
                <input type="hidden" name="symbol" value="${stock.symbol}" />
                <button type="submit" class="sell-btn">Sell</button>
            </form>
        </div>

        <div id="chartContainer">
            <canvas id="priceChart"></canvas>
        </div>
    </div>

    <script>
        const labels = [
            '2025-05-10', '2025-05-11', '2025-05-12',
            '2025-05-13', '2025-05-14', '2025-05-15',
            '2025-05-16'
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
                    borderColor: '#0e1c36',
                    backgroundColor: 'rgba(14, 28, 54, 0.1)',
                    fill: true,
                    tension: 0.3,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                }]
            },
            options: {
                scales: {
                    x: {
                        ticks: { color: '#0e1c36' },
                        grid: { color: '#ddd' }
                    },
                    y: {
                        ticks: { color: '#0e1c36' },
                        grid: { color: '#eee' },
                        beginAtZero: false
                    }
                },
                plugins: {
                    legend: {
                        labels: { color: '#0e1c36' }
                    }
                },
                responsive: true,
                maintainAspectRatio: false,
            }
        });
    </script>
</body>
</html>
