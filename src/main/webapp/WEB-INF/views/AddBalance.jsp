<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddBalancePage</title>

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
        position: relative;
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
        background-color: #ff7f00;
        border: none;
        border-radius: 6px;
        color: white;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .header-left button:hover {
        background-color: #e66900;
    }

    h2 {
        margin: 0;
        font-size: 1.4rem;
    }

    .header-center {
        text-align: center;
        flex-grow: 1;
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
        color: #ff7f00;
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
        width: 220px;
        min-height: 100vh;
        float: left;
        padding: 2rem 1rem;
        transition: transform 0.3s ease;
        position: fixed;
        top: 0;
        left: 0;
        overflow-y: auto;
        z-index: 1000;
    }

    aside ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    aside ul li {
        margin-bottom: 1.5rem;
    }

    aside ul li a {
        text-decoration: none;
        color: white;
        font-weight: 500;
        transition: color 0.3s;
        display: block;
    }

    aside ul li a:hover {
        color: #ffd700;
    }

    main {
        margin-left: 220px;
        padding: 2rem;
        transition: margin-left 0.3s ease;
    }

    .balance-form-container {
        background-color: white;
        border-radius: 10px;
        padding: 2rem;
        max-width: 500px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        margin: 2rem auto;
        text-align: center;
    }

    .balance-form-container h3 {
        margin-bottom: 1.5rem;
        color: #0e1c36;
    }

    .balance-form-container input[type="number"] {
        padding: 0.6rem;
        border-radius: 6px;
        border: 1px solid #ccc;
        width: 100%;
        max-width: 300px;
        margin-bottom: 1.5rem;
        font-size: 1rem;
    }

    .balance-form-container button {
        padding: 0.6rem 1.2rem;
        background-color: #ff7f00;
        border: none;
        border-radius: 6px;
        color: white;
        font-size: 1rem;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .balance-form-container button:hover {
        background-color: #e66900;
    }

    footer {
        clear: both;
        padding: 1rem;
        text-align: center;
        background-color: #0e1c36;
        color: white;
        margin-top: 2rem;
    }

    /* Hamburger toggle button */
    .hamburger {
        display: none;
        font-size: 1.8rem;
        color: white;
        cursor: pointer;
        background: none;
        border: none;
    }

    /* Responsive styles */
    @media (max-width: 900px) {
        aside {
            transform: translateX(-100%);
            position: fixed;
            height: 100%;
        }
        aside.active {
            transform: translateX(0);
        }

        main {
            margin-left: 0;
            padding: 2rem 1rem;
        }

        .hamburger {
            display: block;
        }

        .header-center {
            text-align: left;
            flex-grow: unset;
            margin-left: 1rem;
        }
    }
</style>

</head>
<body>

<div>
   <header>
       <button class="hamburger" id="hamburgerBtn" aria-label="Toggle Menu">
           <i class="fas fa-bars"></i>
       </button>

       <div class="header-left">
           <form action="/user/search" method="get" style="display: flex; gap: 0.5rem;">
               <input type="text" name="query" placeholder="Search">
               <button type="submit">Search</button>
           </form>
       </div>

       <div class="header-center">
           <h2>WELCOME ${username}</h2>
       </div>

       <div class="header-right">
           <div class="wallet-info">
               <h3>Wallet Balance</h3>
               <p>${balance}</p>
               <a href="/user/addbalance">Add Balance</a>
           </div>
           <a href="${pageContext.request.contextPath}/user/profile" class="icon-btn" title="Profile">
               <i class="fas fa-user-circle"></i>
           </a>
           <a href="${pageContext.request.contextPath}/user/logout" class="icon-btn" title="Logout">
               <i class="fas fa-sign-out-alt"></i>
           </a>
       </div>
   </header>

   <aside id="sidebar">
        <ul>
            <li><a href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
            <li><a href="${pageContext.request.contextPath}/user/dashBoard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/portfolio">Portfolio</a></li>
            <li><a href="${pageContext.request.contextPath}/api/stocks/view">Stocks</a></li>
            <li><a href="${pageContext.request.contextPath}/trades">Buy/Sell</a></li>
            <li><a href="${pageContext.request.contextPath}/transactions">Transaction</a></li>
            <li><a href="${pageContext.request.contextPath}/user/wallet">Wallet</a></li>
            <li><a href="${pageContext.request.contextPath}/user/logout">Log Out</a></li>
        </ul>
   </aside>

   <main id="mainContent">
       <div class="balance-form-container">
           <h3>Enter Amount to Add</h3>
           <form action="${pageContext.request.contextPath}/user/add" method="post">
               <input type="number" name="cash" placeholder="Enter amount" required />
               <br>
               <button type="submit">Add Cash</button>
           </form>
       </div>
   </main>

   <footer>
       &copy; 2025 Trading App | All rights reserved
   </footer>
</div>

<script>
    const hamburgerBtn = document.getElementById('hamburgerBtn');
    const sidebar = document.getElementById('sidebar');

    hamburgerBtn.addEventListener('click', () => {
        sidebar.classList.toggle('active');
    });
</script>

</body>
</html>
