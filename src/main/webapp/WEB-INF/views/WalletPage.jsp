<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WalletPage</title>

<!-- FontAwesome CDN for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    background-color: #f8fafb;
    color: #1a1a1a;
    line-height: 1.5;
}

main {
    margin-left: 220px;
    padding: 2rem;
    min-height: calc(100vh - 120px);
}

.wallet-container {
    max-width: 1200px;
    margin: 0 auto;
}

/* Page Header */
.page-header {
    margin-bottom: 2rem;
    border-bottom: 1px solid #e8eaed;
    padding-bottom: 1rem;
}

.page-title {
    font-size: 1.5rem;
    font-weight: 600;
    color: #1a1a1a;
    margin: 0;
}

.balance-tabs {
    display: flex;
    gap: 2rem;
    margin-top: 1rem;
}

.tab-item {
    padding: 0.5rem 0;
    color: #666;
    text-decoration: none;
    border-bottom: 2px solid transparent;
    font-weight: 500;
    transition: all 0.2s ease;
}

.tab-item.active {
    color: #00d09c;
    border-bottom-color: #00d09c;
}

/* Main Content Layout */
.main-content {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 2rem;
    margin-bottom: 2rem;
}

.card {
    background: #ffffff;
    border-radius: 12px;
    border: 1px solid #e8eaed;
    overflow: hidden;
    box-shadow: 0 1px 3px rgba(0,0,0,0.02);
}

/* Balance Card */
.balance-card {
    padding: 1.5rem;
}

.balance-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
}

.balance-title {
    font-size: 0.9rem;
    color: #666;
    font-weight: 500;
}

.balance-amount {
    font-size: 2rem;
    font-weight: 700;
    color: #1a1a1a;
    margin-bottom: 0.5rem;
}

.balance-details {
    background: #f8fafb;
    border-radius: 8px;
    padding: 1rem;
    margin-top: 1rem;
}

.balance-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.5rem 0;
    border-bottom: 1px solid #e8eaed;
}

.balance-row:last-child {
    border-bottom: none;
}

.balance-label {
    font-size: 0.9rem;
    color: #666;
}

.balance-value {
    font-size: 0.9rem;
    font-weight: 600;
    color: #1a1a1a;
}

.add-btn {
    background: #00d09c;
    border: none;
    border-radius: 6px;
    color: white;
    padding: 0.4rem 0.8rem;
    font-size: 0.8rem;
    cursor: pointer;
    font-weight: 500;
}

/* Actions Card */
.actions-card {
    padding: 0;
}

.actions-header {
    padding: 1.5rem 1.5rem 1rem;
    border-bottom: 1px solid #f0f0f0;
    display: flex;
    gap: 1rem;
}

.action-tab {
    padding: 0.5rem 1rem;
    background: transparent;
    border: none;
    color: #666;
    font-weight: 500;
    cursor: pointer;
    border-radius: 6px;
    transition: all 0.2s ease;
}

.action-tab.active {
    background: #00d09c;
    color: white;
}

.actions-content {
    padding: 1.5rem;
}

.action-form {
    display: none;
}

.action-form.active {
    display: block;
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-label {
    display: block;
    font-size: 0.9rem;
    font-weight: 500;
    color: #333;
    margin-bottom: 0.5rem;
}

.form-input {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #e8eaed;
    border-radius: 8px;
    font-size: 1rem;
    transition: border-color 0.2s ease;
}

.form-input:focus {
    outline: none;
    border-color: #00d09c;
}

.amount-shortcuts {
    display: flex;
    gap: 0.5rem;
    margin-top: 0.5rem;
}

.amount-btn {
    padding: 0.4rem 0.8rem;
    background: #f8fafb;
    border: 1px solid #e8eaed;
    border-radius: 6px;
    font-size: 0.8rem;
    cursor: pointer;
    transition: all 0.2s ease;
}

.amount-btn:hover {
    background: #00d09c;
    color: white;
    border-color: #00d09c;
}

.submit-btn {
    width: 100%;
    padding: 0.75rem;
    background: #00d09c;
    border: none;
    border-radius: 8px;
    color: white;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.submit-btn:hover {
    background: red;
}

.submit-btn:disabled {
    background: #ccc;
    cursor: not-allowed;
}

/* Transaction History */
.transactions-section {
    background: white;
    border-radius: 12px;
    border: 1px solid #e8eaed;
    overflow: hidden;
}

.transactions-header {
    padding: 1.5rem;
    border-bottom: 1px solid #e8eaed;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.transactions-title {
    font-size: 1.1rem;
    font-weight: 600;
    color: #1a1a1a;
    margin: 0;
}

.view-all-btn {
    color: #00d09c;
    text-decoration: none;
    font-size: 0.9rem;
    font-weight: 500;
}

.transactions-table {
    width: 100%;
    border-collapse: collapse;
}

.transactions-table th {
    background: #f8fafb;
    padding: 1rem 1.5rem;
    text-align: left;
    font-size: 0.9rem;
    font-weight: 600;
    color: #666;
    border-bottom: 1px solid #e8eaed;
}

.transactions-table td {
    padding: 1rem 1.5rem;
    border-bottom: 1px solid #f0f0f0;
    font-size: 0.9rem;
}

.transaction-type {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.type-icon {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.8rem;
}

.type-icon.credit {
    background: #e8f5e8;
    color: #00d09c;
}

.type-icon.debit {
    background: #fee;
    color: #ff4757;
}

.amount-credit {
    color: #00d09c;
    font-weight: 600;
}

.amount-debit {
    color: #ff4757;
    font-weight: 600;
}

.transaction-date {
    color: #666;
    font-size: 0.8rem;
}

.no-transactions {
    text-align: center;
    padding: 2rem;
    color: #666;
}

/* Responsive Design */
@media (max-width: 1200px) {
    main {
        margin-left: 0;
        padding: 1.5rem;
    }
}

@media (max-width: 768px) {
    main {
        padding: 1rem;
    }
    
    .main-content {
        grid-template-columns: 1fr;
        gap: 1rem;
    }
    
    .balance-amount {
        font-size: 1.6rem;
    }
    
    .transactions-table th,
    .transactions-table td {
        padding: 0.75rem 1rem;
    }
    
    .amount-shortcuts {
        flex-wrap: wrap;
    }
}

@media (max-width: 480px) {
    .balance-tabs {
        gap: 1rem;
    }
    
    .actions-header {
        padding: 1rem;
        gap: 0.5rem;
    }
    
    .actions-content {
        padding: 1rem;
    }
    
    .transactions-table {
        font-size: 0.8rem;
    }
    
    .transactions-table th,
    .transactions-table td {
        padding: 0.5rem;
    }
}

/* Animations */
.card {
    animation: fadeInUp 0.4s ease-out;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.success-message {
    background: #e8f5e8;
    color: #00d09c;
    padding: 0.75rem;
    border-radius: 6px;
    margin-bottom: 1rem;
    font-size: 0.9rem;
    display: none;
}

.error-message {
    background: #fee;
    color: #ff4757;
    padding: 0.75rem;
    border-radius: 6px;
    margin-bottom: 1rem;
    font-size: 0.9rem;
    display: none;
}
</style>

</head>
<body>
<jsp:include page="header.jsp" />
<div>



<main>
    <div class="wallet-container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">INR Balance</h1>
            <div class="balance-tabs">
                <a href="#" class="tab-item active">Stocks, F&O balance</a>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Balance Card -->
            <div class="card balance-card">
                <div class="balance-header">
                    <span class="balance-title">Stocks, F&O balance</span>
                </div>
               <span class="balance-value" id="cashBalance">
    ₹<fmt:formatNumber value="${balance}" type="number" minFractionDigits="2" />
</span>

                
                <div class="balance-details">
                    <div class="balance-row">
                        <span class="balance-label">Cash</span>
                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                            <span class="balance-value" id="cashBalance">₹${balance}</span>
                            <button class="add-btn" onclick="focusAddMoney()">Add</button>
                        </div>
                    </div>
                    <div class="balance-row">
                        <span class="balance-label">Pledge</span>
                        <span class="balance-value">₹0.00</span>
                    </div>
                </div>
            </div>
            
            <!-- Actions Card -->
            <div class="card actions-card">
                <div class="actions-header">
                    <button class="action-tab active" onclick="switchTab('add')">Add money</button>
                    <button class="action-tab" onclick="switchTab('withdraw')">Withdraw</button>
                </div>
                <div class="actions-content">
                    <div id="successMessage" class="success-message"></div>
                    <div id="errorMessage" class="error-message"></div>
                    
                    <!-- Add Money Form -->
                    <div id="addForm" class="action-form active">
                        <form action="${pageContext.request.contextPath}/wallet/add" method="post">
                            <div class="form-group">
                                <label class="form-label">Enter Amount</label>
                                <input type="number" class="form-input" name="amount" id="addAmount" placeholder="₹ 0" min="1" required>
                                <div class="amount-shortcuts">
                                    <button type="button" class="amount-btn" onclick="setAmount('add', 500)">₹ 500</button>
                                    <button type="button" class="amount-btn" onclick="setAmount('add', 1000)">₹ 1000</button>
                                    <button type="button" class="amount-btn" onclick="setAmount('add', 2000)">₹ 2000</button>
                                    <button type="button" class="amount-btn" onclick="setAmount('add', 5000)">₹ 5000</button>
                                </div>
                            </div>
                            <button type="submit" class="submit-btn">Add money</button>
                        </form>
                    </div>
                    
                    <!-- Withdraw Form -->
                    <div id="withdrawForm" class="action-form">
                        <form action="wallet/withdraw" method="post">
                            <div class="form-group">
                                <label class="form-label">Enter Amount</label>
                                <input type="number" class="form-input"  name="amount" id="withdrawAmount" placeholder="₹ 0" min="1" required>
                                <div class="amount-shortcuts">
                                    <button type="button" class="amount-btn" onclick="setAmount('withdraw', 500)">₹ 500</button>
                                    <button type="button" class="amount-btn" onclick="setAmount('withdraw', 1000)">₹ 1000</button>
                                    <button type="button" class="amount-btn" onclick="setAmount('withdraw', 2000)">₹ 2000</button>
                                </div>
                            </div>
                            <button type="submit" class="submit-btn" >Withdraw money</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Transaction History -->
       <div class="transactions-section">
    <div class="transactions-header">
        <h3 class="transactions-title">All transactions</h3>
        <a href="#" class="view-all-btn">View all</a>
    </div>

    <div id="transactionsContainer">
        <table class="transactions-table">
            <thead>
                <tr>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="transactionsList">
                <c:choose>
                    <c:when test="${not empty transactions}">
                        <c:forEach items="${transactions}" var="txn">
                            <tr>
                                <td>${txn.type}</td>
                                <td>₹${txn.amount}</td>
                                <td><fmt:formatDate value="${txn.dateTime}" pattern="dd-MM-yyyy HH:mm:ss" /></td>
                                <td>
                                    <span style="color: ${txn.status == 'SUCCESS' ? 'green' : 'red'};">
                                        ${txn.status}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4" class="no-transactions">
                                <i class="fas fa-history" style="font-size: 2rem; color: #ccc; margin-bottom: 0.5rem;"></i>
                                <div>No transactions yet</div>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

</main>

<jsp:include page="footer.jsp" />
</div>

<script>
// Get initial balance from JSP
let currentBalance = parseFloat('${balance}'.replace('₹', '').replace(',', '') || '0');
let transactions = [];

// Switch between Add/Withdraw tabs
function switchTab(type) {
    // Update tab buttons
    document.querySelectorAll('.action-tab').forEach(tab => {
        tab.classList.remove('active');
    });
    event.target.classList.add('active');
    
    // Update forms
    document.querySelectorAll('.action-form').forEach(form => {
        form.classList.remove('active');
    });
    
    if (type === 'add') {
        document.getElementById('addForm').classList.add('active');
    } else {
        document.getElementById('withdrawForm').classList.add('active');
    }
    
    // Clear messages
    hideMessages();
}

// Set amount shortcuts
function setAmount(type, amount) {
    const input = type === 'add' ? document.getElementById('addAmount') : document.getElementById('withdrawAmount');
    input.value = amount;
}

// Focus add money tab and input
function focusAddMoney() {
    // Switch to add tab
    switchTab('add');
    document.querySelector('.action-tab').click();
    // Focus input
    setTimeout(() => {
        document.getElementById('addAmount').focus();
    }, 100);
}

// Handle transaction submission
function handleTransaction(event, type) {
    event.preventDefault();
    
    const amount = parseFloat(type === 'add' ? 
        document.getElementById('addAmount').value : 
        document.getElementById('withdrawAmount').value);
    
    if (!amount || amount <= 0) {
        showError('Please enter a valid amount');
        return;
    }
    
    if (type === 'withdraw' && amount > currentBalance) {
        showError('Insufficient balance');
        return;
    }
    
    // Update balance
    if (type === 'add') {
        currentBalance += amount;
        showSuccess(`₹${amount.toFixed(2)} added successfully`);
    } else {
        currentBalance -= amount;
        showSuccess(`₹${amount.toFixed(2)} withdrawn successfully`);
    }
    
    // Update UI
    updateBalanceDisplay();
    addTransaction(type, amount);
    
    // Clear form
    event.target.reset();
    
    // Here you would typically send the transaction to your backend
    // Example: submitToBackend(type, amount);
}

// Update balance display
function updateBalanceDisplay() {
    const formattedBalance = `₹${currentBalance.toLocaleString('en-IN', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    })}`;
    
    document.getElementById('currentBalance').textContent = formattedBalance;
    document.getElementById('cashBalance').textContent = formattedBalance;
}

// Add transaction to history
function addTransaction(type, amount) {
    const transaction = {
        id: Date.now(),
        type: type,
        amount: amount,
        date: new Date(),
        status: 'Completed'
    };
    
    transactions.unshift(transaction);
    updateTransactionsList();
}

// Update transactions list
function updateTransactionsList() {
    const tbody = document.getElementById('transactionsList');
    
    if (transactions.length === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="4" class="no-transactions">
                    <i class="fas fa-history" style="font-size: 2rem; color: #ccc; margin-bottom: 0.5rem;"></i>
                    <div>No transactions yet</div>
                </td>
            </tr>
        `;
        return;
    }
    
    tbody.innerHTML = '';
    
    // Show last 5 transactions
    transactions.slice(0, 5).forEach(transaction => {
        const row = document.createElement('tr');
        const isCredit = transaction.type === 'add';
        
        row.innerHTML = `
            <td>
                <div class="transaction-type">
                    <div class="type-icon ${isCredit ? 'credit' : 'debit'}">
                        <i class="fas fa-${isCredit ? 'plus' : 'minus'}"></i>
                    </div>
                    <span>${isCredit ? 'Money Added' : 'Money Withdrawn'}</span>
                </div>
            </td>
            <td>
                <span class="${isCredit ? 'amount-credit' : 'amount-debit'}">
                    ${isCredit ? '+' : '-'}₹${transaction.amount.toFixed(2)}
                </span>
            </td>
            <td>
                <div>${transaction.date.toLocaleDateString('en-IN')}</div>
                <div class="transaction-date">${transaction.date.toLocaleTimeString('en-IN', {hour: '2-digit', minute: '2-digit'})}</div>
            </td>
            <td>
                <span style="color: #00d09c; font-weight: 500;">${transaction.status}</span>
            </td>
        `;
        
        tbody.appendChild(row);
    });
}

// Show success message
function showSuccess(message) {
    const successDiv = document.getElementById('successMessage');
    successDiv.textContent = message;
    successDiv.style.display = 'block';
    
    setTimeout(() => {
        successDiv.style.display = 'none';
    }, 3000);
}

// Show error message
function showError(message) {
    const errorDiv = document.getElementById('errorMessage');
    errorDiv.textContent = message;
    errorDiv.style.display = 'block';
    
    setTimeout(() => {
        errorDiv.style.display = 'none';
    }, 3000);
}

// Hide all messages
function hideMessages() {
    document.getElementById('successMessage').style.display = 'none';
    document.getElementById('errorMessage').style.display = 'none';
}

// Initialize balance display
document.addEventListener('DOMContentLoaded', function() {
    updateBalanceDisplay();
});

// Function to submit to backend (integrate with your JSP backend)
function submitToBackend(type, amount) {
    // Example implementation - adjust according to your backend
    /*
    fetch('/wallet/transaction', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            type: type,
            amount: amount,
            timestamp: new Date().toISOString()
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Transaction successful
        } else {
            showError(data.message || 'Transaction failed');
        }
    })
    .catch(error => {
        showError('Network error. Please try again.');
    });
    */
}
</script>
</body>
</html>