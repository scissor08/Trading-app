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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
<style>
  * { box-sizing: border-box; }
  html, body {
    margin: 0; padding: 0; height: 100vh;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    display: flex; flex-direction: column;
  }
  main { flex: 1; padding: 2rem; background: white; overflow-y: auto; }
  .table-container {
    overflow-x: auto; background-color: white; padding: 1rem;
    border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  }
  table { width: 100%; border-collapse: collapse; }
  th, td {
    padding: 0.75rem 1rem; border-bottom: 1px solid #ddd; text-align: left;
  }
  th { background-color: #0e1c36; color: white; }
  tr:hover { background-color: #f1f1f1; }
  .icon-btn { cursor: pointer; margin-left: 1rem; font-size: 1.2rem; }
  .context-menu {
    display: none; position: absolute; z-index: 1000;
    background-color: white; border: 1px solid #ccc; padding: 0.5rem;
    box-shadow: 0 0 10px rgba(0,0,0,0.2);
  }
  .context-menu div { padding: 5px 10px; cursor: pointer; }
  .context-menu div:hover { background-color: #eee; }
</style>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="main-wrapper">
  <main>
    <h2>Stock Overview Table</h2>
    <canvas id="stockChart" height="100"></canvas>
    <div class="table-container mt-4">
      <table id="stockTable">
        <thead>
          <tr>
            <th>Symbol</th><th>High</th><th>Low</th><th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="stock" items="${stocks}">
            <tr data-symbol="${stock.symbol}" data-high="${stock.high}" data-low="${stock.low}">
              <td>${stock.symbol}</td><td>${stock.high}</td><td>${stock.low}</td>
              <td><i class="fas fa-plus icon-btn plus-btn"></i></td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
    <div class="context-menu" id="contextMenu">
      <div onclick="addToWatchlist()">Add to Watchlist</div>
    </div>
  </main>
  <jsp:include page="footer.jsp" />
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
        labels: { color: 'black' }
      }
    },
    scales: {
      x: { ticks: { color: 'black' } },
      y: { ticks: { color: 'black' } }
    }
  }
});

$(document).ready(function() {
	  // Add to watchlist on single click
	  $('.plus-btn').on('click', function() {
	    const row = $(this).closest('tr');
	    const symbol = row.data('symbol');

	    $.ajax({
	      url: '/api/watchlist/add',
	      method: 'POST',
	      contentType: 'application/json',
	      data: JSON.stringify({ symbol: symbol}),
	      success: () => alert('Added to watchlist'),
	      error: () => alert('Already added to watchlist or error occurred')
	    });
	  });

	  // Double click to increment quantity
	  $('#stockTable tr').on('dblclick', function() {
	    const symbol = $(this).data('symbol');
	    $.ajax({
	      url: '/api/watchlist/increment/' + symbol,
	      method: 'PUT',
	      success: () => alert("Quantity incremented for " + symbol),
	      error: () => alert("Failed to increment quantity")
	    });
	  });
	});

function getToken() {
    return localStorage.getItem("jwtToken");
}

document.addEventListener("DOMContentLoaded", function() {
    fetch('/dashboard', {
        method: 'GET',
        headers: {
            "Authorization": "Bearer " + getToken()
        }
    })
    .then(response => response.json())
    .then(data => console.log("Dashboard Data:", data))
    .catch(error => console.error("Error fetching dashboard data:", error));
});
</script>
</body>
</html>
