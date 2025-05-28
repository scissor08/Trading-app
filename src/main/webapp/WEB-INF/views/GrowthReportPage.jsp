<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>

<!-- FontAwesome CDN for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

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

  .container {
    display: flex;
    min-height: calc(100vh - 100px);
  }

  aside {
    background-color: #1e2d50;
    color: white;
    width: 220px;
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

  main {
    flex-grow: 1;
    padding: 2rem;
    background-color: #ffffff;
    overflow-y: auto;
    box-shadow: inset 0 0 5px rgba(0,0,0,0.05);
  }

  .download-dropdown {
    position: relative;
    display: inline-block;
    float: right;
    margin-bottom: 1.5rem;
  }

  .dropdown-button {
    background-color: #007bff;
    color: white;
    padding: 0.6rem 1rem;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
  }

  .dropdown-button:hover {
    background-color: #0056b3;
  }

  .dropdown-content {
    display: none;
    position: absolute;
    right: 0;
    background-color: #ffffff;
    min-width: 180px;
    box-shadow: 0px 8px 16px rgba(0,0,0,0.15);
    z-index: 1;
    border-radius: 6px;
    overflow: hidden;
  }

  .dropdown-content a {
    color: #0e1c36;
    padding: 0.75rem 1rem;
    text-decoration: none;
    display: block;
    transition: background 0.3s;
  }

  .dropdown-content a:hover {
    background-color: #f1f1f1;
  }

  .download-dropdown:hover .dropdown-content {
    display: block;
  }

  h2 {
    margin: 0;
    color: #0e1c36;
  }

  main h2 {
    margin-bottom: 1.5rem;
    color: #0e1c36;
  }

  .table-responsive {
    overflow-x: auto;
    background-color: #fff;
    padding: 1rem;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }

  table {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.95rem;
  }

  th, td {
    padding: 0.75rem 1rem;
    text-align: center;
    border: 1px solid #dee2e6;
  }

  thead {
    background-color: #0e1c36;
    color: white;
  }

  tbody tr:hover {
    background-color: #f1f1f1;
  }

  footer {
    clear: both;
    padding: 1rem;
    text-align: center;
    background-color: #0e1c36;
    color: white;
  }
</style>

</head>
<body>
  <header>
    <div class="header-left">
      <form action="/user/search" method="get" style="display: flex; gap: 0.5rem;">
        <input type="text" name="query" placeholder="Search">
        <button type="submit">Search</button>
      </form>
    </div>

    <div class="header-center">
      <h2>WELCOME ${userDetails.name}</h2>
    </div>

    <div class="header-right">
      <div class="wallet-info">
        <h3>Wallet Balance</h3>
        <p>${userAccount.balance}</p>
        <a href="/addbalance">Add Balance</a>
      </div>
      <a href="${pageContext.request.contextPath}/profile" class="icon-btn" title="Profile">
        <i class="fas fa-user-circle"></i>
      </a>
      <a href="${pageContext.request.contextPath}/logout" class="icon-btn" title="Logout">
        <i class="fas fa-sign-out-alt"></i>
      </a>
    </div>
  </header>

  <div class="container">
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
      <div style="display: flex; justify-content: space-between; align-items: center;">
        <h2>Growth Report</h2>

        <div class="download-dropdown">
          <button class="dropdown-button"><i class="fas fa-download"></i> Download Report</button>
          <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/download/pdf">Download as PDF</a>
            <a href="${pageContext.request.contextPath}/download/excel">Download as Excel</a>
            <a href="${pageContext.request.contextPath}/download/csv">Download as CSV</a>
          </div>
        </div>
      </div>

      <div class="table-responsive">
        <table>
          <thead>
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
    </main>
  </div>
  
  <footer>
    &copy; 2025 Trading App | All rights reserved
  </footer>
</body>
</html>
