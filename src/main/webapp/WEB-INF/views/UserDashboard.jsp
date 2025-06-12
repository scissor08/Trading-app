<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

  /* Live Indices Styles */
  .indices-container {
    background: linear-gradient(135deg, #0e1c36 0%, #1a2744 100%);
    border-radius: 15px;
    padding: 2rem;
    margin-bottom: 2rem;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    color: white;
  }

  .indices-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
    border-bottom: 2px solid rgba(255, 255, 255, 0.1);
    padding-bottom: 1rem;
  }

  .indices-title {
    color: #ffffff;
    font-size: 1.5rem;
    font-weight: 600;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }

  .last-updated {
    color: #b0bec5;
    font-size: 0.9rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }

  .indices-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 1.5rem;
  }

  .index-card {
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 12px;
    padding: 1.5rem;
    transition: all 0.3s ease;
    backdrop-filter: blur(10px);
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
    background: linear-gradient(90deg, #00d4ff, #0099cc);
  }

  .index-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 40px rgba(0, 212, 255, 0.2);
    border-color: rgba(0, 212, 255, 0.4);
  }

  .index-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
  }

  .symbol {
    font-size: 1.2rem;
    font-weight: 700;
    color: #ffffff;
  }

  .status-indicator {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    position: relative;
  }

  .status-live {
    background: #00ff88;
    box-shadow: 0 0 10px rgba(0, 255, 136, 0.6);
    animation: pulse 2s infinite;
  }

  @keyframes pulse {
    0% { opacity: 1; transform: scale(1); }
    50% { opacity: 0.7; transform: scale(1.1); }
    100% { opacity: 1; transform: scale(1); }
  }

  .index-name {
    color: #b0bec5;
    font-size: 0.9rem;
    margin-bottom: 1rem;
    font-weight: 500;
  }

  .price-section {
    margin-bottom: 1rem;
  }

  .current-price {
    font-size: 2rem;
    font-weight: 700;
    color: #ffffff;
    margin-bottom: 0.5rem;
  }

  .change-section {
    display: flex;
    align-items: center;
    gap: 1rem;
    font-weight: 600;
  }

  .change-section.positive {
    color: #00ff88;
  }

  .change-section.negative {
    color: #ff4757;
  }

  .change-value {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 1rem;
  }

  .trend-arrow {
    font-size: 1.2rem;
    font-weight: bold;
  }

  .change-percent {
    font-size: 0.9rem;
    opacity: 0.9;
  }

  .loading-indicator {
    display: none;
    color: #00d4ff;
    font-size: 0.9rem;
    margin-left: 0.5rem;
  }

  /* Responsive design */
  @media (max-width: 768px) {
    .indices-grid {
      grid-template-columns: 1fr;
    }
    
    .indices-container {
      padding: 1.5rem;
    }
    
    .current-price {
      font-size: 1.5rem;
    }
    
    .indices-header {
      flex-direction: column;
      align-items: flex-start;
      gap: 1rem;
    }
  }
</style>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="main-wrapper">
<jsp:include page="ticker.jsp" />

<main>
  <!-- Live Indices Section -->
  <div class="indices-container">
    <div class="indices-header">
      <h3 class="indices-title">
        <i class="fas fa-chart-line"></i>
        Live Market Indices
      </h3>
      <div class="last-updated">
        <i class="fas fa-clock"></i>
        Last Updated: <span id="lastUpdated"><fmt:formatDate value="<%= new java.util.Date() %>" pattern="MMM dd, yyyy HH:mm:ss" /></span>
        <span class="loading-indicator" id="loadingIndicator">
          <i class="fas fa-spinner fa-spin"></i>
        </span>
      </div>
    </div>
    
    <div class="indices-grid" id="indicesGrid">
      <c:forEach var="index" items="${indices}">
        <div class="index-card" data-symbol="${index.symbol}">
          <div class="index-header">
            <div class="symbol">${index.symbol}</div>
            <div class="status-indicator status-live"></div>
          </div>
          <div class="index-name">${index.label}</div>
          <div class="price-section">
            <div class="current-price">
              <fmt:formatNumber value="${index.price}" type="number" pattern="#,##0.00"/>
            </div>
          </div>
          <div class="change-section ${index.change >= 0 ? 'positive' : 'negative'}">
            <div class="change-value">
              <span class="trend-arrow">${index.change >= 0 ? '↗' : '↘'}</span>
              <fmt:formatNumber value="${index.change}" type="number" pattern="+#,##0.00;-#,##0.00"/>
            </div>
            <div class="change-percent">
              (<fmt:formatNumber value="${index.changePercent}" type="number" pattern="+#0.00;-#0.00"/>%)
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>

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
          <tr data-symbol="${stock.symbol}" data-high="${stock.high}" data-low="${stock.low}" data-price="${stock.price}" data-change="${stock.change}">
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
// Stock data for chart
const stockSymbols = [<c:forEach var="s" items="${stocks}" varStatus="status">'${s.symbol}'<c:if test="${!status.last}">,</c:if></c:forEach>];
const stockHighs = [<c:forEach var="s" items="${stocks}" varStatus="status">${s.high}<c:if test="${!status.last}">,</c:if></c:forEach>];
const stockLows = [<c:forEach var="s" items="${stocks}" varStatus="status">${s.low}<c:if test="${!status.last}">,</c:if></c:forEach>];

// Chart initialization (if you have a chart element)
if (document.getElementById('stockChart')) {
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
}

// Live Indices Update Function
function updateLiveIndices() {
  const loadingIndicator = document.getElementById('loadingIndicator');
  loadingIndicator.style.display = 'inline-block';
  
  $.ajax({
    url: '/api/indices/live',
    method: 'GET',
    dataType: 'json',
    success: function(data) {
      updateIndicesDisplay(data);
      updateLastUpdatedTime();
      loadingIndicator.style.display = 'none';
    },
    error: function(xhr, status, error) {
      console.error('Error fetching live indices:', error);
      loadingIndicator.style.display = 'none';
    }
  });
}

function updateIndicesDisplay(indices) {
  const indicesGrid = document.getElementById('indicesGrid');
  
  indices.forEach(function(index) {
    const card = indicesGrid.querySelector(`[data-symbol="${index.symbol}"]`);
    if (card) {
      // Update price
      const priceElement = card.querySelector('.current-price');
      const newPrice = parseFloat(index.price).toLocaleString('en-US', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
      });
      
      // Add flash effect for price change
      if (priceElement.textContent !== newPrice) {
        priceElement.style.background = 'rgba(0, 212, 255, 0.3)';
        setTimeout(() => {
          priceElement.style.background = 'transparent';
        }, 1000);
      }
      priceElement.textContent = newPrice;
      
      // Update change section
      const changeSection = card.querySelector('.change-section');
      const changeValue = card.querySelector('.change-value');
      const changePercent = card.querySelector('.change-percent');
      const trendArrow = card.querySelector('.trend-arrow');
      
      // Determine if positive or negative
      const isPositive = parseFloat(index.change) >= 0;
      changeSection.className = `change-section ${isPositive ? 'positive' : 'negative'}`;
      
      // Update arrow
      trendArrow.textContent = isPositive ? '↗' : '↘';
      
      // Update change value
      const formattedChange = (isPositive ? '+' : '') + parseFloat(index.change).toLocaleString('en-US', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
      });
      changeValue.innerHTML = `<span class="trend-arrow">${trendArrow.textContent}</span>${formattedChange}`;
      
      // Update change percent
      const formattedPercent = (isPositive ? '+' : '') + parseFloat(index.changePercent).toFixed(2);
      changePercent.textContent = `(${formattedPercent}%)`;
    }
  });
}

function updateLastUpdatedTime() {
  const now = new Date();
  const options = { 
    year: 'numeric', 
    month: 'short', 
    day: '2-digit', 
    hour: '2-digit', 
    minute: '2-digit', 
    second: '2-digit',
    hour12: false
  };
  document.getElementById('lastUpdated').textContent = now.toLocaleDateString('en-US', options);
}

$(document).ready(function() {
  // Add to watchlist functionality
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

  // Start live updates for indices
  // Update every 30 seconds
  setInterval(updateLiveIndices, 30000);
  
  // Initial update after 5 seconds
  setTimeout(updateLiveIndices, 5000);
});
</script>
</body>
</html>