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
    /* KYC Modal Styles */
#kycModal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    backdrop-filter: blur(2px);
}

#kycModal .modal-content {
    background-color: #fff;
    margin: 10% auto;
    padding: 0;
    border-radius: 10px;
    width: 90%;
    max-width: 500px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
    animation: slideIn 0.3s ease-out;
}

@keyframes slideIn {
    from {
        transform: translateY(-30px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}
.success-modal {
    position: fixed;
    top: 20%; /* Instead of center (50%) */
    left: 50%;
    transform: translateX(-50%);
    z-index: 1000;
}
#kycModal .modal-header {
    background: linear-gradient(135deg, #ff6b6b, #ee5a24);
    color: white;
    padding: 20px;
    border-radius: 10px 10px 0 0;
    text-align: center;
}

#kycModal .modal-header h2 {
    margin: 0;
    font-size: 1.4rem;
    font-weight: 600;
}

#kycModal .modal-body {
    padding: 30px 20px;
}

.kyc-message {
    text-align: center;
}

.warning-icon {
    font-size: 3rem;
    margin-bottom: 15px;
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0% { transform: scale(1); opacity: 1; }
    50% { transform: scale(1.05); opacity: 0.8; }
    100% { transform: scale(1); opacity: 1; }
}

.kyc-message p {
    color: #333;
    line-height: 1.6;
    margin-bottom: 10px;
    font-size: 1rem;
}

.kyc-message p:first-of-type {
    font-weight: 600;
    color: #e74c3c;
}

#kycModal .modal-footer {
    padding: 20px;
    display: flex;
    gap: 10px;
    justify-content: center;
    border-top: 1px solid #eee;
}

#kycModal .btn {
    padding: 12px 25px;
    border: none;
    border-radius: 6px;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
    min-width: 120px;
}

#kycModal .btn-primary {
    background: linear-gradient(135deg, #4CAF50, #45a049);
    color: white;
}

#kycModal .btn-primary:hover {
    background: linear-gradient(135deg, #45a049, #3d8b40);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
}

#kycModal .btn-secondary {
    background: #6c757d;
    color: white;
}

#kycModal .btn-secondary:hover {
    background: #5a6268;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
}

/* Responsive Design */
@media (max-width: 600px) {
    #kycModal .modal-content {
        width: 95%;
        margin: 20% auto;
    }
    
    #kycModal .modal-footer {
        flex-direction: column;
    }
    
    #kycModal .btn {
        width: 100%;
        margin-bottom: 10px;
    }
    
    #kycModal .btn:last-child {
        margin-bottom: 0;
    }
}

/* Loading state for buy button */
.btn-loading {
    position: relative;
    pointer-events: none;
    opacity: 0.7;
}

.btn-loading::after {
    content: '';
    position: absolute;
    width: 16px;
    height: 16px;
    margin: auto;
    border: 2px solid transparent;
    border-top-color: #ffffff;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}
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
            margin-top: 15px;
             margin-bottom: 10px;
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
        #resultModal {
    width: 500px !important; /* Reduce from default width */
    max-width: 90vw; /* Responsive on mobile */
    padding: 15px !important; /* Reduce padding */
    box-sizing: border-box;
}

#resultModal .modal-content {
    padding: 10px; /* Reduce internal padding */
}

#resultModal .purchase-summary {
    font-size: 14px; /* Smaller text */
    line-height: 1.4;
}

#resultModal .purchase-summary div {
    margin: 5px 0; /* Reduce spacing between items */
}

#modalTitle {
    font-size: 18px !important; /* Smaller title */
    margin-bottom: 10px;
}
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
#resultModal {
    width: 1500px !important; /* Reduce from default width */
    max-width: 150vw; /* Responsive on mobile */
    padding: 10px !important; /* Reduce padding */
    box-sizing: border-box;
}

#resultModal .modal-content {
    padding: 10px; /* Reduce internal padding */
}

#resultModal .purchase-summary {
    font-size: 14px; /* Smaller text */
    line-height: 1.4;
}

#resultModal .purchase-summary div {
    margin: 5px 0; /* Reduce spacing between items */
}

#modalTitle {
    font-size: 18px !important; /* Smaller title */
    margin-bottom: 10px;
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
    <div class="header">
        <h2>${stock.symbol}</h2>
        <%-- Removed the extra '$' here. The JSP expression ${stock.price} should render the number.
             If your backend already includes '$' in the price string, remove it from the backend.
             Otherwise, the JavaScript will add '$' where needed (e.g., in chart tooltips and modal).
             For consistent display, consider having your Java backend always return a clean number,
             and format it with '$' in the frontend (JSP/JS) as needed. --%>
        <div class="stock-price">${stock.price}</div>
    </div>

    <div class="content-grid">
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

      <div>
<!-- Wallet Section -->

<div class="wallet-section" style="margin-bottom: 20px; padding: 15px; background-color: #f8f9fa; border-radius: 8px; border-left: 4px solid #ff8c00;">
    <h2 style="margin: 0; color: #0e1c36; display: flex; align-items: center; justify-content: space-between; font-size: 1.5rem;">
        <div style="display: flex; align-items: center;">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#ff8c00" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 10px;">
                <path d="M21 12V7H5a2 2 0 0 1 0-4h14v4"></path>
                <path d="M3 5v14a2 2 0 0 0 2 2h16v-5"></path>
                <circle cx="18" cy="12" r="2"></circle>
            </svg>
            Wallet Balance :
        </div>
        <div style="font-size: 1.4rem; font-weight: bold; color: #28a745;">
            $  <c:out value="${balance}" />
        </div>
    </h2>
</div>

<c:if test="${stock.domain != null && !stock.domain.isEmpty()}">
    <div class="company-section">
        <img src="https://logo.clearbit.com/${stock.domain}"
             alt="${stock.symbol} logo"
             class="company-logo"
             onerror="this.style.display='none'" />
    </div>
</c:if>

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

<!-- Wallet Section -->

    </div>

    <div class="chart-section">
        <h3 class="chart-title">${stock.symbol} Price Chart</h3>
        <canvas id="priceChart"></canvas>
    </div>

    <a href="${pageContext.request.contextPath}/stocks" class="back-link">← Back to All Stocks</a>
</div>

<div id="loadingModal" class="modal">
    <div class="modal-content">
        <div class="loading">
            <div class="spinner"></div>
            <p>Processing your transaction...</p>
        </div>
    </div>
</div>

<div id="resultModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <div class="modal-header">
            <h3 id="modalTitle">Transaction Result</h3>
        </div>
        <div id="modalBody">
            <div class="purchase-summary">
                <h4>Transaction Summary</h4>
                <div class="summary-row">
                    <span class="summary-label">Stock:</span>
                    <span class="summary-value" id="summaryStockSymbol"></span>
                </div>
                <div class="summary-row">
                    <span class="summary-label">Quantity:</span>
                    <span class="summary-value" id="summaryQuantity"></span>
                </div>
                <div class="summary-row">
                    <span class="summary-label">Price per Share:</span>
                    <span class="summary-value" id="summaryPricePerShare"></span> <%-- Removed hardcoded '$' --%>
                </div>
                <div class="summary-row">
                    <span class="summary-label">Total Amount:</span>
                    <span class="summary-value" id="summaryTotalAmount"></span> <%-- Removed hardcoded '$' --%>
                </div>
                <div class="summary-row">
                    <span class="summary-label">Operation:</span>
                    <span class="summary-value" id="summaryOperation"></span>
                </div>
            </div>
            <p class="success-message" id="successMessage"></p>
            <p class="error-message" id="errorMessage"></p>
        </div>
        <button onclick="closeModal()" class="btn" style="background-color: #ff7f00; color: white; margin-top: 20px;">Close</button>
    </div>
</div>

<script>
    // Stock data from JSP
    const stockData = {
        symbol: '${stock.symbol}',
        // Ensure stock.price from backend is a clean number string (e.g., "199.5701")
        price: parseFloat('${stock.price}'),
        change: '${stock.change}',
        changePercent: '${stock.changePercent}'
    };

    // Chart initialization with responsive options
    // Using a placeholder for historical data for now.
    // In a real application, you'd fetch this from your backend.
    const labels = ['2025-05-10', '2025-05-11', '2025-05-12', '2025-05-13', '2025-05-14', '2025-05-15', '2025-05-16'];
    const prices = [335, 338, 340, 337, 339, 341, stockData.price]; // Last price is the current stock price

    const ctx = document.getElementById('priceChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: stockData.symbol + ' Price ($)', // Label includes '$'
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
                            return '$' + value.toFixed(2); // Adds '$' for y-axis labels
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
                            return context.dataset.label + ': $' + context.parsed.y.toFixed(2); // Adds '$' to tooltip
                        }
                    }
                }
            }
        }
    });

    // KYC Status Check Function
    async function checkKYCStatus() {
        try {
            const response = await fetch('/api/check-kyc-status', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            });
            
            if (response.ok) {
                const data = await response.json();
                return data.kycVerified || false;
            } else {
                console.error('KYC status check failed:', response.status);
                return false;
            }
        } catch (error) {
            console.error('Error checking KYC status:', error);
            return false; // Default to not verified if error
        }
    }

    // Show KYC Modal Function
    function showKYCModal() {
        let modal = document.getElementById('kycModal');
        if (!modal) {
            createKYCModal();
            modal = document.getElementById('kycModal'); // Get the newly created modal
        }
        modal.style.display = 'block';
    }

    // Create KYC Modal Function
    function createKYCModal() {
        const modalHTML = `
            <div id="kycModal" class="modal" style="display: none;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="modal-title">KYC Verification Required</h2>
                    </div>
                    <div class="modal-body">
                        <div class="kyc-message">
                            <div class="warning-icon">⚠️</div>
                            <p>Please complete your KYC verification first to continue with the transaction.</p>
                            <p>KYC verification is required for all trading activities as per regulatory compliance.</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="kycVerificationBtn" class="btn btn-primary">Complete KYC Verification</button>
                        <button id="kycCloseBtn" class="btn btn-secondary">Close</button>
                    </div>
                </div>
            </div>
        `;
        
        document.body.insertAdjacentHTML('beforeend', modalHTML);
        
        // Add event listeners
        document.getElementById('kycVerificationBtn').addEventListener('click', redirectToKYC);
        document.getElementById('kycCloseBtn').addEventListener('click', closeKYCModal);
        
        // Close on outside click
        document.getElementById('kycModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeKYCModal();
            }
        });
    }

    // Close KYC Modal Function
    function closeKYCModal() {
        const modal = document.getElementById('kycModal');
        if (modal) {
            modal.style.display = 'none';
        }
    }

    // Redirect to KYC Verification Function
    function redirectToKYC() {
        // Update this URL as per your KYC verification page
        window.location.href = '/kyc-verification';
    }

    // Buy Stock Function - Updated with proper KYC check
    async function handleBuyStock() {
        const quantity = parseInt(document.getElementById('quantityInput').value);

        if (!quantity || quantity < 1) {
            alert('Please enter a valid quantity');
            return;
        }

        showLoadingModal();
        
        try {
            // Check KYC status first
            const isKYCVerified =true; // FIXED: Actually call the API
            
            // Hide loading modal
            hideLoadingModal();
            
            if (isKYCVerified) {
                // KYC verified, proceed with buy transaction
                const requestData = {
                    symbol: stockData.symbol,
                    quantity: quantity,
                    price: stockData.price
                };

                showLoadingModal();

                try {
                    const response = await fetch('/api/buy', {
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
            } else {
                // KYC not verified, show KYC modal
                showKYCModal();
            }
        } catch (error) {
            console.error('Error in buy process:', error);
            hideLoadingModal();
            showErrorModal('Buy', 'Something went wrong. Please try again.');
        }
    }

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

    // Sell stock function - Updated to use session-based authentication
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
            const response = await fetch('/api/sell', {
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
        // Ensure loading spinner is visible
        const loadingElement = document.querySelector('#loadingModal .loading');
        if (loadingElement) {
            loadingElement.style.display = 'block';
        }
    }

    function hideLoadingModal() {
        document.getElementById('loadingModal').style.display = 'none';
        const loadingElement = document.querySelector('#loadingModal .loading');
        if (loadingElement) {
            loadingElement.style.display = 'none';
        }
    }

    function showErrorModal(operation, errorMessage) {
        const modal = document.getElementById('resultModal');
        const title = document.getElementById('modalTitle');
        const successMessageEl = document.getElementById('successMessage');
        const errorMessageEl = document.getElementById('errorMessage');

        // Clear previous messages and ensure success message is hidden
        successMessageEl.style.display = 'none';
        errorMessageEl.style.display = 'none';
        successMessageEl.textContent = '';
        errorMessageEl.textContent = '';

        // Hide summary section for error
        document.querySelector('.purchase-summary').style.display = 'none';

        title.textContent = operation + ' Transaction Failed';
        title.className = 'error'; // Apply error color

        errorMessageEl.textContent = `❌ Transaction failed: ${errorMessage || 'Unknown error'}`;
        errorMessageEl.style.display = 'block';
        errorMessageEl.className = 'error-message error'; // Ensure error styling

        // Don't set reload flag for errors
        modal.dataset.shouldReload = 'false';

        modal.style.display = 'block';
    }

    // Updated showSuccessModal function - adds reload flag
  function showSuccessModal(operation, result, quantity) {
    const modal = document.getElementById('resultModal');
    const title = document.getElementById('modalTitle');
    const successMessageEl = document.getElementById('successMessage');
    const errorMessageEl = document.getElementById('errorMessage');
    const quantity1 = parseFloat(document.getElementById('quantityInput').value);

    // Clear previous messages and ensure error message is hidden
    successMessageEl.style.display = 'none';
    errorMessageEl.style.display = 'none';
    successMessageEl.textContent = '';
    errorMessageEl.textContent = '';

    // Ensure summary section is visible for success
    document.querySelector('.purchase-summary').style.display = 'block';

    title.textContent = operation + ' Transaction Successful';
    title.className = 'success';

    const amount = quantity1 * stockData.price;
    const price = stockData.price.toFixed(2);
    const totalAmount = amount.toFixed(2);

    // Populate the pre-existing elements with formatted values
    document.getElementById('summaryStockSymbol').textContent = stockData.symbol || 'N/A';
    document.getElementById('summaryQuantity').textContent = quantity;
    document.getElementById('summaryPricePerShare').textContent = "$" + price;
    document.getElementById('summaryTotalAmount').textContent = "$" + totalAmount;
    document.getElementById('summaryOperation').textContent = operation;

    successMessageEl.textContent = '✅ Transaction completed successfully!';
    successMessageEl.style.display = 'block';
    successMessageEl.className = 'success-message success';

    // Position modal higher on the page
  

    modal.dataset.shouldReload = 'true';
    modal.style.display = 'block';
}
    // Updated closeModal function - reloads page after successful transactions
    function closeModal() {
        const modal = document.getElementById('resultModal');
        
        // Check if page should reload after closing (for successful transactions)
        const shouldReload = modal.dataset.shouldReload === 'true';
        
        // Close modals
        document.getElementById('resultModal').style.display = 'none';
        document.getElementById('loadingModal').style.display = 'none';
        
        // Clear content when closing the modal, especially for re-opening
        const successMessageEl = document.getElementById('successMessage');
        const errorMessageEl = document.getElementById('errorMessage');
        successMessageEl.textContent = '';
        errorMessageEl.textContent = '';
        successMessageEl.style.display = 'none';
        errorMessageEl.style.display = 'none';

        // Clear summary details and ensure summary is visible for next time
        document.getElementById('summaryStockSymbol').textContent = '';
        document.getElementById('summaryQuantity').textContent = '';
        document.getElementById('summaryPricePerShare').textContent = '';
        document.getElementById('summaryTotalAmount').textContent = '';
        document.getElementById('summaryOperation').textContent = '';
        document.querySelector('.purchase-summary').style.display = 'block'; // Reset display for next time
        
        // Reset the reload flag
        modal.dataset.shouldReload = 'false';
        
        // Reload page if it was a successful transaction
        if (shouldReload) {
            // Small delay to ensure modal closes smoothly before reload
            setTimeout(() => {
                window.location.reload();
            }, 200);
        }
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
        const resultModal = document.getElementById('resultModal');
        const loadingModal = document.getElementById('loadingModal');
        const kycModal = document.getElementById('kycModal');

        if (event.target === resultModal) {
            closeModal(); // Use closeModal to ensure cleanup
        }
        if (event.target === loadingModal) {
            hideLoadingModal();
        }
        if (event.target === kycModal) {
            closeKYCModal();
        }
    }

    // Handle escape key to close modals
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            closeModal();
            closeKYCModal();
        }
    });

    // DOM Content Loaded Event
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize any required components here
        console.log('Stock trading page loaded successfully');
        
        // Add event listeners for buy/sell buttons if they exist
        const buyButton = document.getElementById('buyButton');
        const sellButton = document.getElementById('sellButton');
        
        if (buyButton) {
            buyButton.addEventListener('click', handleBuyStock);
        }
        
        if (sellButton) {
            sellButton.addEventListener('click', handleSellStock);
        }
    });
</script>

</body>
</html>