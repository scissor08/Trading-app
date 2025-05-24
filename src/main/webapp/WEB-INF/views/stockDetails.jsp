<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stock Details - ${stock.symbol}</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            color: #0e1c36;
            line-height: 1.6;
        }

        /* Container with responsive padding */
        .container {
            max-width: 1200px;
            margin: 20px auto;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        /* Responsive header */
        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h2 {
            color: #0e1c36;
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .stock-price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #28a745;
        }

        /* Responsive grid layout */
        .content-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 30px;
        }

        /* Stock info section */
        .stock-info {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: white;
            border-radius: 6px;
            border-left: 4px solid #ff7f00;
        }

        .info-label {
            font-weight: bold;
            color: #0e1c36;
        }

        .info-value {
            color: #555;
        }

        .info-value a {
            color: #ff7f00;
            text-decoration: none;
        }

        .info-value a:hover {
            text-decoration: underline;
        }

        /* Company logo section */
        .company-section {
            text-align: center;
            padding: 20px;
        }

        .company-logo {
            max-width: 100px;
            height: auto;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        /* Trading section */
        .trading-section {
            background-color: #f8f9fa;
            padding: 25px;
            border-radius: 8px;
            text-align: center;
        }

        .quantity-container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 20px 0;
            gap: 10px;
            flex-wrap: wrap;
        }

        .quantity-label {
            font-weight: bold;
            color: #0e1c36;
            margin-right: 10px;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .quantity-input {
            width: 80px;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 6px;
            text-align: center;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .quantity-input:focus {
            outline: none;
            border-color: #ff7f00;
        }

        .quantity-btn {
            width: 35px;
            height: 35px;
            border: none;
            background-color: #ff7f00;
            color: white;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            font-size: 18px;
            transition: background-color 0.3s;
        }

        .quantity-btn:hover {
            background-color: #e66b00;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 30px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            min-width: 120px;
        }

        .btn-buy {
            background-color: #28a745;
            color: white;
        }

        .btn-buy:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }

        .btn-sell {
            background-color: #dc3545;
            color: white;
        }

        .btn-sell:hover {
            background-color: #c82333;
            transform: translateY(-2px);
        }

        /* Chart section */
        .chart-section {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .chart-title {
            text-align: center;
            margin-bottom: 20px;
            color: #0e1c36;
            font-size: 1.2rem;
        }

        #priceChart {
            width: 100% !important;
            height: 300px !important;
        }

        /* Back link */
        .back-link {
            display: inline-block;
            margin-top: 30px;
            padding: 10px 20px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s;
        }

        .back-link:hover {
            background-color: #5a6268;
        }

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            padding: 20px;
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 30px;
            border-radius: 12px;
            width: 90%;
            max-width: 500px;
            text-align: center;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            position: relative;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            position: absolute;
            right: 15px;
            top: 10px;
        }

        .close:hover {
            color: #000;
        }

        .loading {
            display: none;
        }

        .spinner {
            border: 4px solid #f3f3f3;
            border-top: 4px solid #ff7f00;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 0 auto 20px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .purchase-summary {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 25px;
            border-radius: 12px;
            margin: 20px 0;
            text-align: left;
            border: 1px solid #dee2e6;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .purchase-summary h4 {
            margin-bottom: 20px;
            color: #0e1c36;
            font-size: 1.3rem;
            text-align: center;
            padding-bottom: 10px;
            border-bottom: 2px solid #ff7f00;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 12px 0;
            padding: 8px 0;
            border-bottom: 1px solid #e9ecef;
        }

        .summary-row:last-of-type {
            border-bottom: none;
            font-weight: bold;
            font-size: 1.1rem;
            color: #0e1c36;
            background-color: rgba(255, 127, 0, 0.1);
            padding: 12px;
            border-radius: 6px;
            margin-top: 15px;
        }

        .summary-label {
            font-weight: 600;
            color: #495057;
        }

        .summary-value {
            font-weight: 500;
            color: #0e1c36;
        }

        .success-message {
            text-align: center;
            margin-top: 20px;
            padding: 15px;
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            border-radius: 8px;
            border: 1px solid #c3e6cb;
        }

        .success-icon {
            font-size: 2rem;
            margin-bottom: 10px;
            display: block;
        }

        .error-message {
            text-align: center;
            margin-top: 20px;
            padding: 15px;
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            border-radius: 8px;
            border: 1px solid #f5c6cb;
        }

        .error-icon {
            font-size: 2rem;
            margin-bottom: 10px;
            display: block;
        }

        .success {
            color: #28a745;
        }

        .error {
            color: #dc3545;
        }

        /* Tablet Styles */
        @media (min-width: 768px) {
            .container {
                margin: 40px auto;
                padding: 40px;
            }

            .content-grid {
                grid-template-columns: 2fr 1fr;
                gap: 40px;
            }

            .header h2 {
                font-size: 2.5rem;
            }

            .chart-section {
                grid-column: 1 / -1;
            }

            #priceChart {
                height: 400px !important;
            }

            .action-buttons {
                gap: 20px;
            }

            .btn {
                min-width: 140px;
            }
        }

        /* Desktop Styles */
        @media (min-width: 1024px) {
            .container {
                padding: 50px;
            }

            .info-grid {
                grid-template-columns: repeat(3, 1fr);
            }

            .quantity-container {
                gap: 15px;
            }

            .quantity-input {
                width: 100px;
            }

            .action-buttons {
                gap: 25px;
            }

            .btn {
                padding: 15px 40px;
                font-size: 18px;
                min-width: 160px;
            }
        }

        /* Large Desktop */
        @media (min-width: 1200px) {
            .content-grid {
                grid-template-columns: 1.5fr 1fr;
            }

            #priceChart {
                height: 450px !important;
            }
        }

        /* Mobile Styles */
        @media (max-width: 767px) {
            .container {
                margin: 10px;
                padding: 15px;
                border-radius: 8px;
            }

            .header h2 {
                font-size: 1.8rem;
            }

            .stock-price {
                font-size: 1.3rem;
            }

            .info-grid {
                grid-template-columns: 1fr;
                gap: 10px;
            }

            .info-item {
                flex-direction: column;
                align-items: flex-start;
                text-align: left;
            }

            .info-label {
                margin-bottom: 5px;
            }

            .quantity-container {
                flex-direction: column;
                gap: 15px;
            }

            .quantity-label {
                margin-right: 0;
                margin-bottom: 10px;
            }

            .action-buttons {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 200px;
            }

            .chart-title {
                font-size: 1rem;
            }

            #priceChart {
                height: 250px !important;
            }

            .modal-content {
                margin: 20% auto;
                padding: 20px;
            }

            .purchase-summary p {
                flex-direction: column;
                gap: 5px;
            }
        }

        /* Extra small mobile */
        @media (max-width: 480px) {
            .container {
                margin: 5px;
                padding: 10px;
            }

            .header h2 {
                font-size: 1.5rem;
            }

            .stock-price {
                font-size: 1.1rem;
            }

            .quantity-btn {
                width: 30px;
                height: 30px;
                font-size: 16px;
            }

            .quantity-input {
                width: 70px;
                padding: 8px;
            }

            .btn {
                padding: 10px 20px;
                font-size: 14px;
            }
        }

        /* Touch device optimizations */
        @media (hover: none) and (pointer: coarse) {
            .btn, .quantity-btn {
                min-height: 44px; /* Apple's recommended touch target size */
            }

            .quantity-input {
                min-height: 44px;
            }
        }

        /* Print styles */
        @media print {
            .action-buttons, .back-link {
                display: none;
            }

            .container {
                box-shadow: none;
                border: 1px solid #ccc;
            }
        }

        /* High contrast mode support */
        @media (prefers-contrast: high) {
            .info-item {
                border: 2px solid #000;
            }

            .btn {
                border: 2px solid currentColor;
            }
        }

        /* Reduced motion support */
        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Header Section -->
    <div class="header">
        <h2>${stock.symbol}</h2>
        <div class="stock-price">$${stock.price}</div>
    </div>

    <!-- Main Content Grid -->
    <div class="content-grid">
        <!-- Stock Information -->
        <div class="stock-info">
            <h3 style="margin-bottom: 20px; color: #0e1c36;">Stock Information</h3>
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Change:</span>
                    <span class="info-value">${stock.change}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Change %:</span>
                    <span class="info-value">${stock.changePercent}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Open:</span>
                    <span class="info-value">${stock.open}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">High:</span>
                    <span class="info-value">${stock.high}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Low:</span>
                    <span class="info-value">${stock.low}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Previous Close:</span>
                    <span class="info-value">${stock.previousClose}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Trading Day:</span>
                    <span class="info-value">${stock.latestTradingDay}</span>
                </div>
                <c:if test="${stock.domain != null && !stock.domain.isEmpty()}">
                    <div class="info-item">
                        <span class="info-label">Website:</span>
                        <span class="info-value">
                            <a href="https://${stock.domain}" target="_blank">${stock.domain}</a>
                        </span>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Company and Trading Section -->
        <div>
            <!-- Company Logo -->
            <c:if test="${stock.domain != null && !stock.domain.isEmpty()}">
                <div class="company-section">
                    <img src="https://logo.clearbit.com/${stock.domain}" 
                         alt="${stock.symbol} logo" 
                         class="company-logo"
                         onerror="this.style.display='none'" />
                </div>
            </c:if>

            <!-- Trading Section -->
            <div class="trading-section">
                <h3 style="margin-bottom: 20px; color: #0e1c36;">Trade ${stock.symbol}</h3>
                
                <div class="quantity-container">
                    <span class="quantity-label">Quantity:</span>
                    <div class="quantity-controls">
                        <button class="quantity-btn" onclick="decrementQuantity()" type="button">-</button>
                        <input type="number" id="quantityInput" class="quantity-input" value="1" min="1" max="1000">
                        <button class="quantity-btn" onclick="incrementQuantity()" type="button">+</button>
                    </div>
                </div>

                <div class="action-buttons">
                    <button type="button" class="btn btn-buy" onclick="handleBuyStock()">Buy Stock</button>
                    <button type="button" class="btn btn-sell" onclick="handleSellStock()">Sell Stock</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Chart Section -->
    <div class="chart-section">
        <h3 class="chart-title">${stock.symbol} Price Chart</h3>
        <canvas id="priceChart"></canvas>
    </div>

    <a href="${pageContext.request.contextPath}/stocks" class="back-link">← Back to All Stocks</a>
</div>

<!-- Loading Modal -->
<div id="loadingModal" class="modal">
    <div class="modal-content">
        <div class="loading">
            <div class="spinner"></div>
            <p>Processing your transaction...</p>
        </div>
    </div>
</div>

<!-- Result Modal -->
<div id="resultModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <div class="modal-header">
            <h3 id="modalTitle">Transaction Result</h3>
        </div>
        <div id="modalBody">
            <!-- Content will be populated by JavaScript -->
        </div>
        <button onclick="closeModal()" class="btn" style="background-color: #ff7f00; color: white; margin-top: 20px;">Close</button>
    </div>
</div>

<script>
    // Stock data from JSP
    const stockData = {
        symbol: '${stock.symbol}',
        price: parseFloat('${stock.price}'),
        change: '${stock.change}',
        changePercent: '${stock.changePercent}'
    };

    // Chart initialization with responsive options
    const labels = ['2025-05-10', '2025-05-11', '2025-05-12', '2025-05-13', '2025-05-14', '2025-05-15', '2025-05-16'];
    const prices = [335, 338, 340, 337, 339, 341, stockData.price];

    const ctx = document.getElementById('priceChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: stockData.symbol + ' Price ($)',
                data: prices,
                borderColor: '#ff7f00',
                backgroundColor: 'rgba(255, 127, 0, 0.2)',
                fill: true,
                tension: 0.2,
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: {
                intersect: false,
                mode: 'index'
            },
            scales: {
                x: {
                    ticks: { 
                        color: '#0e1c36',
                        maxRotation: 45,
                        minRotation: 0
                    },
                    grid: { color: '#e0e0e0' }
                },
                y: {
                    ticks: { 
                        color: '#0e1c36',
                        callback: function(value) {
                            return '$' + value.toFixed(2);
                        }
                    },
                    grid: { color: '#e0e0e0' },
                    beginAtZero: false
                }
            },
            plugins: {
                legend: {
                    labels: { 
                        color: '#0e1c36',
                        padding: 20
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(14, 28, 54, 0.9)',
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    borderColor: '#ff7f00',
                    borderWidth: 1,
                    callbacks: {
                        label: function(context) {
                            return context.dataset.label + ': $' + context.parsed.y.toFixed(2);
                        }
                    }
                }
            }
        }
    });

    // Quantity control functions
    function incrementQuantity() {
        const input = document.getElementById('quantityInput');
        const currentValue = parseInt(input.value) || 1;
        const maxValue = parseInt(input.max) || 1000;
        if (currentValue < maxValue) {
            input.value = currentValue + 1;
        }
    }

    function decrementQuantity() {
        const input = document.getElementById('quantityInput');
        const currentValue = parseInt(input.value) || 1;
        const minValue = parseInt(input.min) || 1;
        if (currentValue > minValue) {
            input.value = currentValue - 1;
        }
    }

    // Validate quantity input
    document.getElementById('quantityInput').addEventListener('input', function() {
        const value = parseInt(this.value);
        const min = parseInt(this.min) || 1;
        const max = parseInt(this.max) || 1000;
        
        if (isNaN(value) || value < min) {
            this.value = min;
        } else if (value > max) {
            this.value = max;
        }
    });

    // Buy stock function
    async function handleBuyStock() {
        const quantity = parseInt(document.getElementById('quantityInput').value);
        
        if (quantity < 1) {
            alert('Please enter a valid quantity');
            return;
        }

        const requestData = {
            symbol: stockData.symbol,
            quantity: quantity,
            price: stockData.price
        };

        showLoadingModal();

        try {
            const userId = getUserId();
            
            const response = await fetch('/api/buy?id=' + userId, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(requestData)
            });

            hideLoadingModal();

            if (response.ok) {
                const result = await response.json();
                showSuccessModal('Buy', result, quantity);
            } else {
                const errorMessage = await response.text();
                showErrorModal('Buy', errorMessage);
            }
        } catch (error) {
            hideLoadingModal();
            showErrorModal('Buy', 'Network error: ' + error.message);
        }
    }

    // Sell stock function
    async function handleSellStock() {
        const quantity = parseInt(document.getElementById('quantityInput').value);
        
        if (quantity < 1) {
            alert('Please enter a valid quantity');
            return;
        }

        const requestData = {
            symbol: stockData.symbol,
            quantity: quantity,
            price: stockData.price
        };

        showLoadingModal();

        try {
            const userId = getUserId();
            
            const response = await fetch('/api/sell?id=' + userId, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(requestData)
            });

            hideLoadingModal();

            if (response.ok) {
                const result = await response.json();
                showSuccessModal('Sell', result, quantity);
            } else {
                const errorMessage = await response.text();
                showErrorModal('Sell', errorMessage);
            }
        } catch (error) {
            hideLoadingModal();
            showErrorModal('Sell', 'Network error: ' + error.message);
        }
    }

    // Modal functions
    function showLoadingModal() {
        document.getElementById('loadingModal').style.display = 'block';
    }

    function hideLoadingModal() {
        document.getElementById('loadingModal').style.display = 'none';
    }

    function showSuccessModal(operation, result, quantity) {
        const modal = document.getElementById('resultModal');
        const title = document.getElementById('modalTitle');
        const body = document.getElementById('modalBody');

        title.textContent = operation + ' Transaction Successful';
        title.className = 'success';

        const totalAmount = quantity * stockData.price;
        
        body.innerHTML = `
            <div class="purchase-summary">
                <h4>Transaction Summary</h4>
                <p><strong>Stock:</strong> <span>${stockData.symbol}</span></p>
                <p><strong>Quantity:</strong> <span>${quantity}</span></p>
                <p><strong>Price per Share:</strong> <span>$${stockData.price}</span></p>
                <p><strong>Total Amount:</strong> <span>$${totalAmount.toFixed(2)}</span></p>
                <p><strong>Operation:</strong> <span>${operation}</span></p>
            </div>
            <p class="success">✅ Transaction completed successfully!</p>
        `;

        modal.style.display = 'block';
    }

    function showErrorModal(operation, errorMessage) {
        const modal = document.getElementById('resultModal');
        const title = document.getElementById('modalTitle');
        const body = document.getElementById('modalBody');

        title.textContent = operation + ' Transaction Failed';
        title.className = 'error';

        body.innerHTML = `
            <p class="error">❌ Transaction failed: ${errorMessage}</p>
            <p>Please try again or contact support if the problem persists.</p>
        `;

        modal.style.display = 'block';
    }

    function closeModal() {
        document.getElementById('resultModal').style.display = 'none';
        document.getElementById('loadingModal').style.display = 'none';
    }

    // Get user ID - implement based on your authentication system
    function getUserId() {
        // Replace with your actual implementation
        return 1;
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
        const resultModal = document.getElementById('resultModal');
        const loadingModal = document.getElementById('loadingModal');
        
        if (event.target === resultModal) {
            resultModal.style.display = 'none';
        }
        if (event.target === loadingModal) {
            loadingModal.style.display = 'none';
        }
    }

    // Handle escape key to close modals
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            closeModal();
        }
    });
</script>

</body>
</html>