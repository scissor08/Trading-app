<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

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
  grid-template-rows: auto 1fr auto;
  grid-template-areas: 
    "header header"
    "aside main"
    "footer footer";
  min-height: 100vh;
}

/* Header Section */
header {
  grid-area: header;
  background-color: var(--card);
  color: var(--highlight);
  padding: 20px;
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

header form {
  display: flex;
  gap: 0.5rem;
}

header input[type="text"] {
  padding: 10px 15px;
  width: 250px;
  border: 1px solid var(--highlight);
  border-radius: 8px;
  background-color: #222;
  color: var(--highlight);
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

header h2 {
  font-size: 1.5rem;
  margin-left: 1rem;
}

/* Wallet Box */
.wallet-info {
  background-color: #222;
  padding: 15px;
  width: 200px;
  border-radius: 10px;
  text-align: center;
  box-shadow: 0 0 10px var(--shadow);
}

.wallet-info h3 {
  margin-bottom: 10px;
}

.wallet-info p {
  font-size: 1.2rem;
  font-weight: bold;
}

.wallet-info a {
  display: inline-block;
  margin-top: 10px;
  color: var(--highlight);
  text-decoration: none;
  border: 1px solid var(--highlight);
  padding: 5px 10px;
  border-radius: 5px;
}

.wallet-info a:hover {
  background-color: var(--highlight);
  color: black;
}

/* Icons */
.icon-btn {
  color: var(--highlight);
  font-size: 1.5rem;
  margin-left: 1rem;
  text-decoration: none;
}

.icon-btn:hover {
  color: #fff;
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
  padding: 0;
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
  color: var(--highlight);
  text-align: center;
  padding: 1rem;
}
</style>
</head>
<body>
<div>
  <header>
    <form action="/search" method="get">
      <input type="text" name="query" placeholder="Search">
      <input type="submit" value="Search" />
    </form>

    <h2>Welcome, ${username}</h2>

    <div class="wallet-info">
      <h3>Wallet Balance</h3>
      <p>${balance}</p>
      <a href="/addbalance">Add Balance</a>
    </div>

    <a href="${pageContext.request.contextPath}/profile" class="icon-btn" title="Profile">
      <i class="fas fa-user-circle"></i>
    </a>
    <a href="${pageContext.request.contextPath}/logout" class="icon-btn" title="Logout">
      <i class="fas fa-sign-out-alt"></i>
    </a>
  </header>

  <aside>
    <ul>
      <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
      <li><a href="${pageContext.request.contextPath}/dashBoard">Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/portfolio">Portfolio</a></li>
      <li><a href="${pageContext.request.contextPath}/stocks">Stocks</a></li>
      <li><a href="${pageContext.request.contextPath}/trades">Buy/Sell</a></li>
      <li><a href="${pageContext.request.contextPath}/transactions">Transaction</a></li>
      <li><a href="${pageContext.request.contextPath}/wallet">Wallet</a></li>
      <li><a href="${pageContext.request.contextPath}/logout">Log Out</a></li>
    </ul>
  </aside>

  <main>
    <!-- Your dashboard content goes here -->
  </main>

  <footer>
    &copy; 2025 Trading App | All rights reserved
  </footer>
</div>
</body>
</html>
