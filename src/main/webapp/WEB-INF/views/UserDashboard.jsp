<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- styles are unchanged -->
<style>
/* your CSS here remains unchanged */
</style>
</head>
<body>
<div>
  <header>
    <form action="/search" method="get">
      <input type="text" name="query" placeholder="Search">
      <input type="submit" value="Search" />
    </form>

    <h2>Welcome, ${username}</h2>

    <div class="wallet-info">
      <h3>Wallet Balance</h3>
      <p>${balance}</p>
      <a href="/addbalance">Add Balance</a>
    </div>

    <a href="${pageContext.request.contextPath}/profile" class="icon-btn" title="Profile">
      <i class="fas fa-user-circle"></i>
    </a>
    <a href="${pageContext.request.contextPath}/logout" class="icon-btn" title="Logout">
      <i class="fas fa-sign-out-alt"></i>
    </a>
  </header>

  <aside>
    <ul>
      <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
      <li><a href="${pageContext.request.contextPath}/dashBoard">Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/portfolio">Portfolio</a></li>
      <li><a href="${pageContext.request.contextPath}/stocks">Stocks</a></li>
      <li><a href="${pageContext.request.contextPath}/trades">Buy/Sell</a></li>
      <li><a href="${pageContext.request.contextPath}/transactions">Transaction</a></li>
      <li><a href="${pageContext.request.contextPath}/wallet">Wallet</a></li>
      <li><a href="${pageContext.request.contextPath}/logout">Log Out</a></li>
    </ul>
  </aside>

  <main>
    <h2>Market Highlights</h2>
    <div class="stock-cards">
      <c:forEach var="stock" items="${stocks}">
        <div class="stock-card">
          <h3>${stock.symbol}</h3>
          <p><strong>High:</strong> ${stock.high}</p>
          <p><strong>Low:</strong> ${stock.low}</p>
        </div>
      </c:forEach>
    </div>

    <h2 style="margin-top: 50px;">Stock Overview Table</h2>
    <div class="table-container">
      <table>
        <thead>
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
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>

    <h2 style="margin-top: 50px;">Stock Price Comparison</h2>
    <canvas id="stockChart" width="900" height="400"></canvas>
  </main>

  <footer>
    &copy; 2025 Trading App | All rights reserved
  </footer>
</div>

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
        labels: { color: 'orange' }
      }
    },
    scales: {
      x: { ticks: { color: 'orange' } },
      y: { ticks: { color: 'orange' } }
    }
  }
});
</script>
</body>
</html>
