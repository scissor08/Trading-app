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

    html, body {
        margin: 0;
        padding: 0;
        height: 100vh;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        display: flex;
        flex-direction: column;
    }

    header {
        background-color: #f8f8ff;
        padding: 1rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 60px;
        box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
        z-index: 1000;
    }

    .header-left {
        display: flex;
        gap: 1rem;
    }

    .header-left input[type="text"] {
        padding: 0.5rem;
        border-radius: 6px;
        border: 1px solid #ccc;
        min-width: 200px;
         margin-left: 300px;
    }

    .header-left button {
        padding: 0.5rem 1rem;
        background-color: #007bff;
        border: none;
        color: white;
        border-radius: 6px;
        cursor: pointer;
    }

    .main-wrapper {
        flex: 1;
        display: flex;
        flex-direction: row;
        width: 100%;
    }

  aside {
    width: 220px;
    background-color: #1e2d50;
    color: white;
    padding: 2rem 1rem;
    display: flex;
    flex-direction: column;
    align-items: flex-start; /* left align items */
    justify-content: flex-start; /* align to top */
}


 aside ul {
    list-style: none;
    padding: 0;
    margin: 0;
    width: 100%;
}


aside ul li {
    margin-bottom: 1rem;
}

aside ul li a {
    text-decoration: none;
    color: white;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    border-radius: 8px;
    transition: background 0.3s ease, color 0.3s ease;
}

aside ul li a:hover {
    background-color: #2d3e68;
    color: #ffd700;
}

    main {
        flex: 1;
        padding: 2rem;
        background: linear-gradient(to bottom right, #627aff, #8e65e6);
        overflow-y: auto;
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
        border-bottom: 1px solid #ddd;
        text-align: left;
    }

    th {
        background-color: #0e1c36;
        color: white;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    footer {
        background-color: #f8f8ff;
        padding: 1rem;
        text-align: center;
        box-shadow: rgba(0, 0, 0, 0.1) 0px -2px 8px;
    }

    .icon-btn {
        color: black;
        font-size: 1.5rem;
        margin-left: 1rem;
        text-decoration: none;
    }

    .icon-btn:hover {
        color: #ffc107;
    }
</style>
</head>
<body>

<header>
  <div class="header-left">
    <input type="text" id="searchInput" placeholder="Search stocks">
    <button onclick="filterTable()">Search</button>
  </div>
  <div>
    <a href="${pageContext.request.contextPath}/profile" class="icon-btn" title="Profile"><i class="fas fa-user-circle"></i></a>
    <a href="${pageContext.request.contextPath}/logout" class="icon-btn" title="Logout"><i class="fas fa-sign-out-alt"></i></a>
  </div>
</header>

<div class="main-wrapper">
  <aside>
    <ul>
      <li><a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user"></i> Profile</a></li>
      <li><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-chart-line"></i> Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/holdings"><i class="fas fa-hand-holding-usd"></i> Holdings</a></li>
      <li><a href="${pageContext.request.contextPath}/stocks"><i class="fas fa-coins"></i> Stocks</a></li>
      <li><a href="${pageContext.request.contextPath}/trades"><i class="fas fa-exchange-alt"></i> Buy/Sell</a></li>
      <li><a href="${pageContext.request.contextPath}/growthreport"><i class="fas fa-chart-pie"></i> Report</a></li>
      <li><a href="${pageContext.request.contextPath}/transactions"><i class="fas fa-receipt"></i> Transaction</a></li>
      <li><a href="${pageContext.request.contextPath}/wallet"><i class="fas fa-wallet"></i> Wallet</a></li>
      <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Log Out</a></li>
    </ul>
  </aside>

  <main>
    <h2>Stock Overview Table</h2>
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
</div>

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
          labels: { color: 'black' }
        }
      },
      scales: {
        x: { ticks: { color: 'black' } },
        y: { ticks: { color: 'black' } }
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
