<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    * {
        box-sizing: border-box;
    }

    body, html {
        margin: 0;
        padding: 0;
        height: 100%;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    header {
        background-color: #0e1c36;
        color: white;
        padding: 1rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: fixed;
        top: 0;
        left: 200px;
        right: 0;
        z-index: 1000;
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
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        padding: 2rem 1rem;
        overflow-y: auto;
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

    main {
        margin-left: 200px;
        margin-top: 80px; /* Height of header */
        padding: 2rem 3rem;
        height: calc(100vh - 80px);
        overflow-y: auto;
        background-color: #f4f7f9;
    }

    .table-container {
        overflow-x: auto;
        background-color: white;
        padding: 1rem;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 0.75rem 1rem;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #0e1c36;
        color: white;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    footer {
        padding: 1rem;
        text-align: center;
        background-color: #0e1c36;
        color: white;
        position: relative;
        z-index: 1;
    }
</style>
</head>
<body>
  <aside>
    <ul>
      <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
      <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/portfolio">Portfolio</a></li>
      <li><a href="${pageContext.request.contextPath}/stocks">Stocks</a></li>
      <li><a href="${pageContext.request.contextPath}/trades">Buy/Sell</a></li>
      <li><a href="${pageContext.request.contextPath}/transactions">Transaction</a></li>
      <li><a href="${pageContext.request.contextPath}/wallet">Wallet</a></li>
 <li><a href="${pageContext.request.contextPath}/api/holdings">Holdings</a></li>


      <li><a href="${pageContext.request.contextPath}/logout">Log Out</a></li>
    </ul>
  </aside>

  <header>
    <div class="header-left">
      <input type="text" id="searchInput" placeholder="Search stocks">
      <button onclick="filterTable()">Search</button>
    </div>

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
      <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/portfolio">Portfolio</a></li>
      <li><a href="${pageContext.request.contextPath}/stocks">Stocks</a></li>
      <li><a href="${pageContext.request.contextPath}/trades">Buy/Sell</a></li>
      <li><a href="${pageContext.request.contextPath}/growthreport">Profit/Loss Report</a></li>
      <li><a href="${pageContext.request.contextPath}/transactions">Transaction</a></li>
      <li><a href="${pageContext.request.contextPath}/wallet">Wallet</a></li>
      <li><a href="${pageContext.request.contextPath}/logout">Log Out</a></li>
    </ul>
  </aside>

  <main>
   <h2 style="margin-top: 80px;">Stock Overview Table</h2>

    <div class="table-container">
      <table id="stockTable">
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

    function filterTable() {
      var input = document.getElementById("searchInput");
      var filter = input.value.toUpperCase();
      var table = document.getElementById("stockTable");
      var tr = table.getElementsByTagName("tr");

      for (var i = 1; i < tr.length; i++) {
        var td = tr[i].getElementsByTagName("td")[0];
        if (td) {
          var txtValue = td.textContent || td.innerText;
          tr[i].style.display = txtValue.toUpperCase().indexOf(filter) > -1 ? "" : "none";
        }       
      }
    }
  </script>
</body>
</html>
