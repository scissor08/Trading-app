<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<<<<<<< HEAD

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

    footer {
        clear: both;
        padding: 1rem;
        text-align: center;
        background-color: #0e1c36;
        color: white;
        margin-top: 2rem;
    }
=======
<style>
:root {
  --background: #000;
  --card: #111;
  --highlight: #FFA500;
  --shadow: rgba(255, 165, 0, 0.2);
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  background-color: var(--background);
  color: var(--highlight);
  font-family: Arial, sans-serif;
}

div {
  display: grid;
  grid-template-columns: 1fr 4fr;
  grid-template-rows: 1fr 4fr 1fr;
  grid-template-areas: 
    "header header"
    "aside main"
    "footer footer";
}

/* Header Section */
header {
  grid-area: header;
  background-color: var(--card);
  color: var(--highlight);
  padding: 20px;
  position: relative;
}

header h2 {
  text-align: center;
  margin-top: 10px;
  font-size: 28px;
}

/* Search Box */
header form {
  text-align: center;
  margin-top: 20px;
}

header input[type="text"] {
  padding: 10px 15px;
  width: 300px;
  border: 1px solid var(--highlight);
  border-radius: 8px;
  background-color: #222;
  color: var(--highlight);
  margin-right: 10px;
  box-shadow: 0 0 8px var(--shadow);
}

header input[type="submit"] {
  padding: 10px 20px;
  background-color: var(--highlight);
  color: #000;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: bold;
  box-shadow: 0 0 8px var(--shadow);
}

header input[type="submit"]:hover {
  background-color: #ffb733;
}

/* Wallet Box */
header > div {
  position: absolute;
  top: 20px;
  right: 20px; /* moved from left to right */
  background-color: #222;
  padding: 20px;
  width: 220px;
  height: 130px;
  border-radius: 10px;
  box-shadow: 0 0 10px var(--shadow);
  text-align: center;
}

header div h3 {
  margin-bottom: 10px;
}

header div a {
  display: inline-block;
  margin-top: 10px;
  color: var(--highlight);
  text-decoration: none;
  border: 1px solid var(--highlight);
  padding: 5px 10px;
  border-radius: 5px;
}

header div a:hover {
  background-color: var(--highlight);
  color: black;
}

/* Aside Sidebar */
aside {
  grid-area: aside;
  background-color: #111;
  padding-top: 20px;
  min-height: 100vh;
}

aside ul {
  list-style: none;
}

aside li {
  padding: 15px;
  font-size: 18px;
  text-align: center;
  border-bottom: 1px solid #333;
}

aside li:hover {
  background-color: #222;
}

aside a {
  color: var(--highlight);
  text-decoration: none;
}

/* Main Section */
main {
  grid-area: main;
  padding: 40px;
  background-color: var(--background);
}

/* Footer */
footer {
  grid-area: footer;
  background-color: var(--card);
  height: 60px;
}
>>>>>>> c31e7cf (new stock detail and change user searchbox and style)
</style>

</head>
<body>
<div>
<<<<<<< HEAD
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
            <li><a href="${pageContext.request.contextPath}/user/portfolio">Portfolio</a></li>
            <li><a href="${pageContext.request.contextPath}/user/stocks">Stocks</a></li>
            <li><a href="${pageContext.request.contextPath}user/trades">Buy/Sell</a></li>
            <li><a href="${pageContext.request.contextPath}user/transactions">Transaction</a></li>
            <li><a href="${pageContext.request.contextPath}/user/wallet">Wallet</a></li>
            <li><a href="${pageContext.request.contextPath}/user/logout">Log Out</a></li>
        </ul>
   </aside>

   <main>
       <!-- Main content can be placed here -->
   </main>

   <footer>
       &copy; 2025 Trading App | All rights reserved
   </footer>
=======
  <header>
    <h2>Search for a Stock Symbol</h2>
    <form action="${pageContext.request.contextPath}/getStock" method="post">
      <input type="text" name="symbol" placeholder="Enter stock symbol (e.g. AAPL)" required />
      <input type="submit" value="Get Stock" />
    </form>
    <h2>Welcome, ${username}</h2>
    <div>
      <h3>Wallet Balance</h3>
      <p>${balance}</p>
      <a href="#">Add Balance</a>
    </div>
  </header>
  
  <aside>
    <ul>
      <li><a href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
      <li><a href="${pageContext.request.contextPath}/user/dashBoard">Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}">Portfolio</a></li>
      <li><a href="${pageContext.request.contextPath}/stocks">Stocks</a></li>
      <li><a href="${pageContext.request.contextPath}">Buy/Sell</a></li>
      <li><a href="${pageContext.request.contextPath}">Transaction</a></li>
      <li><a href="${pageContext.request.contextPath}">Wallet</a></li>
      <li><a href="${pageContext.request.contextPath}/user/logout">Log Out</a></li>
    </ul>
  </aside>

  <main>
    <!-- Main content here -->
  </main>

  <footer>
    <!-- Optional footer -->
  </footer>
>>>>>>> c31e7cf (new stock detail and change user searchbox and style)
</div>
</body>
</html>
