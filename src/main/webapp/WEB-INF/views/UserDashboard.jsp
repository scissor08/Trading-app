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
 body {
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f7f9;
    }

    header {
        background-color: #0e1c36;
        color: white;
        padding: 1rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
    }

    .header-left {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .header-left input[type="text"] {
        padding: 0.5rem;
        border-radius: 6px;
        border: none;
        outline: none;
        min-width: 200px;
    }

    .header-left button {
        padding: 0.5rem 1rem;
        background-color: #007bff;
        border: none;
        border-radius: 6px;
        color: white;
        cursor: pointer;
    }

    h2 {
        margin: 0;
        font-size: 1.4rem;
    }

    .header-center {
        text-align: center;
    }

    .header-right {
        display: flex;
        align-items: center;
        gap: 1.2rem;
    }

    .wallet-info {
        background-color: #fff;
        color: #0e1c36;
        padding: 0.8rem 1.2rem;
        border-radius: 10px;
        text-align: center;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    .wallet-info h3 {
        margin: 0;
        font-size: 1.1rem;
    }

    .wallet-info p {
        font-size: 1.3rem;
        margin: 0.5rem 0;
        font-weight: bold;
    }

    .wallet-info a {
        text-decoration: none;
        color: #007bff;
        font-weight: bold;
    }

    .icon-btn {
        color: white;
        font-size: 1.5rem;
        text-decoration: none;
        transition: color 0.3s;
    }

    .icon-btn:hover {
        color: #ffc107;
    }

    aside {
        background-color: #1e2d50;
        color: white;
        width: 200px;
        min-height: 100vh;
        float: left;
        padding: 2rem 1rem;
    }

    aside ul {
        list-style-type: none;
        padding: 0;
    }

    aside ul li {
        margin-bottom: 1.5rem;
    }

    aside ul li a {
        text-decoration: none;
        color: white;
        font-weight: 500;
        transition: color 0.3s;
    }

    aside ul li a:hover {
        color: #ffd700;
    }

 /* MAIN CONTENT */
  main {
    grid-area: main;
    padding: 2rem 3rem;
    background-color: var(--color-white);
    overflow-y: auto;
  }
  main p {
    font-size: 1.15rem;
    margin-bottom: 1.2rem;
  }
  main p strong {
    display: inline-block;
    width: 140px;
    color: var(--color-primary);
  }
  main button {
    background-color: #007bff;
    border: none;
    padding: 12px 28px;
    border-radius: 25px;
    font-size: 1rem;
    color: var(--color-text-light);
    cursor: pointer;
    transition: background-color 0.3s ease;
  }
  main button a {
    color: inherit;
    text-decoration: none;
  }

    footer {
        clear: both;
        padding: 1rem;
        text-align: center;
        background-color: #0e1c36;
        color: white;
        margin-top: 2rem;
    }

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
