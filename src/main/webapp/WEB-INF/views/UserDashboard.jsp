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
<jsp:include page="ticker.jsp" />





  <main>
  <!-- Live Indices Section - Add this to your UserDashboard.jsp -->
<div class="indices-section mt-4 mb-4">
  <div class="section-header d-flex justify-content-between align-items-center mb-3">
    <h3 class="section-title">
      <i class="fas fa-chart-line me-2"></i>Live Market Indices
    </h3>
    <small class="text-muted">
      <i class="fas fa-clock me-1"></i>Real-time data
    </small>
  </div>
  
  <div class="indices-grid">
    <c:forEach var="index" items="${indices}">
      <div class="index-card">
        <div class="index-header">
          <div class="index-info">
            <h5 class="index-symbol">${index.symbol}</h5>
            <p class="index-label">${index.label}</p>
          </div>
          <div class="index-icon">
            <i class="fas fa-chart-area"></i>
          </div>
        </div>
        
        <div class="index-price-section">
          <div class="current-price">
            <fmt:formatNumber value="${index.price}" type="number" maxFractionDigits="2" minFractionDigits="2"/>
          </div>
          
          <div class="price-change ${index.change >= 0 ? 'positive' : 'negative'}">
            <span class="change-amount">
              <i class="fas ${index.change >= 0 ? 'fa-arrow-up' : 'fa-arrow-down'}"></i>
              <fmt:formatNumber value="${index.change}" type="number" maxFractionDigits="2" minFractionDigits="2"/>
            </span>
            <span class="change-percent">
              (<fmt:formatNumber value="${index.changePercent}" type="percent" maxFractionDigits="2"/>)
            </span>
          </div>
        </div>
        
        <div class="index-footer">
          <div class="market-status">
            <span class="status-dot ${index.change >= 0 ? 'green' : 'red'}"></span>
            <span class="status-text">Live</span>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

<style>
/* Add this CSS to your existing styles */
.indices-section {
  background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
  border-radius: 10px;
  padding: 1.5rem;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
  border: 1px solid #dee2e6;
}

.section-header {
  border-bottom: 2px solid #0e1c36;
  padding-bottom: 0.75rem;
}

.section-title {
  color: #0e1c36;
  font-weight: 600;
  margin: 0;
  font-size: 1.25rem;
}

.indices-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1.25rem;
  margin-top: 1rem;
}

.index-card {
  background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
  border-radius: 12px;
  padding: 1.25rem;
  border: 1px solid #e9ecef;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.index-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(90deg, #0e1c36, #1e3a5f);
}

.index-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 25px rgba(14, 28, 54, 0.15);
  border-color: #0e1c36;
}

.index-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 1rem;
}

.index-info {
  flex: 1;
}

.index-symbol {
  color: #0e1c36;
  font-weight: 700;
  font-size: 1.1rem;
  margin: 0 0 0.25rem 0;
}

.index-label {
  color: #6c757d;
  font-size: 0.85rem;
  margin: 0;
  font-weight: 500;
}

.index-icon {
  color: #0e1c36;
  opacity: 0.7;
  font-size: 1.25rem;
}

.index-price-section {
  margin-bottom: 1rem;
}

.current-price {
  font-size: 1.5rem;
  font-weight: 700;
  color: #2c3e50;
  margin-bottom: 0.5rem;
}

.price-change {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.9rem;
  font-weight: 600;
}

.price-change.positive {
  color: #28a745;
}

.price-change.negative {
  color: #dc3545;
}

.change-amount, .change-percent {
  display: flex;
  align-items: center;
  gap: 0.25rem;
}

.index-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 0.75rem;
  border-top: 1px solid #e9ecef;
}

.market-status {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.8rem;
  color: #6c757d;
}

.status-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  display: inline-block;
}

.status-dot.green {
  background-color: #28a745;
  box-shadow: 0 0 5px rgba(40, 167, 69, 0.5);
}

.status-dot.red {
  background-color: #dc3545;
  box-shadow: 0 0 5px rgba(220, 53, 69, 0.5);
}

.status-text {
  font-weight: 500;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .indices-grid {
    grid-template-columns: 1fr;
  }
  
  .index-card {
    padding: 1rem;
  }
  
  .current-price {
    font-size: 1.25rem;
  }
}

/* Animation for live data updates */
@keyframes pulse {
  0% { opacity: 1; }
  50% { opacity: 0.7; }
  100% { opacity: 1; }
}

.status-dot.green {
  animation: pulse 2s infinite;
}
</style>
  
    <h2>Stock Overview Table</h2>



    
 

    <div class="table-container mt-4">
      <table id="stockTable">
        <thead>
          <tr>
            <th>Symbol</th><th>High</th><th>Low</th><th>Price</th><th>Change</th><th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="stock" items="${stocks}">
            <tr data-symbol="${stock.symbol}" data-high="${stock.high}" data-low="${stock.low}"  data-low="${stock.price}"  data-low ="${stock.change}">
              <td>${stock.symbol}</td><td>${stock.high}</td><td>${stock.low}</td><td>${stock.price}</td><td>${stock.change}</td>
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

	});
	
	
/* function filterTable() {
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
  } */
</script>
</body>
</html>
