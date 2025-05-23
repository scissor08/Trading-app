<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Growth Report</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="container mt-4">

    <h2 class="mb-4">Growth Report</h2>

    <!-- Report Table -->
    <div class="table-responsive mb-5">
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
                <th>Stock Symbol</th>
                <th>Total Buy Qty</th>
                <th>Total Buy Price</th>
                <th>Total Sell Qty</th>
                <th>Total Sell Price</th>
                <th>Avg Buy</th>
                <th>Avg Sell</th>
                <th>Holdings</th>
                <th>Profit</th>
                <th>Current Profit</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="r" items="${report}">
                <tr>
                    <td>${r.stockSymbol}</td>
                    <td>${r.totalBuyQuantity}</td>
                    <td>${r.totalBuyPrice}</td>
                    <td>${r.totalSellQuantity}</td>
                    <td>${r.totalSellPrice}</td>
                    <td>${r.averageBuyValue}</td>
                    <td>${r.averageSellValue}</td>
                    <td>${r.currentHoldings}</td>
                    <td>${r.profitValue}</td>
                    <td>${r.currentProfitValue}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Graph Section -->
    <h4 class="mb-3">Current Profit by Stock</h4>
    <canvas id="profitChart" height="100"></canvas>

    <script>
        const labels = [
            <c:forEach var="r" items="${report}" varStatus="status">
                '${r.stockSymbol}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        const data = [
            <c:forEach var="r" items="${report}" varStatus="status">
                ${r.currentProfitValue}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        const ctx = document.getElementById('profitChart').getContext('2d');
        const profitChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Current Profit',
                    data: data,
                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Profit Value ($)'
                        }
                    }
                }
            }
        });
    </script>

</body>
</html>
