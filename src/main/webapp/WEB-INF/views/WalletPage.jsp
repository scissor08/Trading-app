<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WalletPage</title>

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

    aside {
        background-color: #1e2d50;
        color: white;
        width: 200px;
        min-height: 100vh;
        float: left;
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
        margin-left: 220px;
        padding: 2rem;
    }

    main form {
        background-color: #fff;
        padding: 2rem;
        border-radius: 12px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        max-width: 500px;
    }

    main h3 {
        margin-top: 0;
        font-size: 1.5rem;
        color: #333;
    }

    main p {
        font-size: 1.8rem;
        font-weight: bold;
        color: #007bff;
    }

    button {
        margin-top: 1rem;
        padding: 0.8rem 1.2rem;
        background-color: #007bff;
        border: none;
        border-radius: 8px;
        color: white;
        font-size: 1rem;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    button:hover {
        background-color: #0056b3;
    }

    button a {
        color: white;
        text-decoration: none;
        display: block;
        width: 100%;
        height: 100%;
    }


    footer {
        clear: both;
        padding: 1rem;
        text-align: center;
        background-color: #0e1c36;
        color: white;
        margin-top: 2rem;
    }
</style>

</head>
<body>
<div>
   <header>
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

   <aside>
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

   <main>
        <form>
           <h3>Your Balance</h3>
           <p>${balance}</p>
           <button><a href="/user/addbalance">Add Balance</a></button>
       </form> 
   </main>
  

   <footer>
       &copy; 2025 Trading App | All rights reserved
   </footer>
</div>
</body>
</html>
