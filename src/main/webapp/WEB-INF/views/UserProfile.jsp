<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>

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

  .container {
    display: flex;
    min-height: calc(100vh - 100px);
  }

  aside {
    background-color: #1e2d50;
    color: white;
    width: 220px;
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
    padding: 2rem 3rem;
    background-color: #fff;
    overflow-y: auto;
    text-align: left;
    max-width: 600px;
    margin: 0 auto;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    border-radius: 12px;
}

main p {
    font-size: 1.15rem;
    margin-bottom: 1.2rem;
}

main p strong {
    display: inline-block;
    width: 160px;
    color: #0e1c36;
}

main button {
    background-color: #007bff;
    border: none;
    padding: 10px 20px;
    border-radius: 25px;
    font-size: 1rem;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin-top: 1rem;
}

  footer {
    clear: both;
    padding: 1rem;
    text-align: center;
    background-color: #0e1c36;
    color: white;
  }
</style>

</head>
<body>
  <header>
    <div class="header-left">
      <form action="/user/search" method="get" style="display: flex; gap: 0.5rem;">
        <input type="text" name="query" placeholder="Search">
        <button type="submit">Search</button>
      </form>
    </div>

    <div class="header-center">
      <h2>WELCOME ${userDetails.name}</h2>
    </div>

<<<<<<< HEAD
       <div class="header-right">
           <div class="wallet-info">
               <h3>Wallet Balance</h3>
               <p>${userAccount.balance}</p>
               <a href="/addbalance">Add Balance</a>
           </div>
           <a href="${pageContext.request.contextPath}/profile" class="icon-btn" title="Profile">
               <i class="fas fa-user-circle"></i>
           </a>
           <a href="${pageContext.request.contextPath}/logout" class="icon-btn" title="Logout">
               <i class="fas fa-sign-out-alt"></i>
           </a>
       </div>
   </header>

<aside>
  <ul>
    <li><a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user"></i> Profile</a></li>
    <li><a href="${pageContext.request.contextPath}/dashboard"><i class="fas fa-chart-line"></i> Dashboard</a></li>
    <li><a href="${pageContext.request.contextPath}/holdings"><i class="fas fa-hand-holding-usd"></i> Holdings</a></li>
    <li><a href="${pageContext.request.contextPath}/stocks"><i class="fas fa-coins"></i> Stocks</a></li>
    <li><a href="${pageContext.request.contextPath}/trades"><i class="fas fa-exchange-alt"></i> Buy/Sell</a></li>
    <li><a href="${pageContext.request.contextPath}/growthreport"><i class="fas fa-chart-pie"></i>Report</a></li>
    <li><a href="${pageContext.request.contextPath}/transactions"><i class="fas fa-receipt"></i> Transaction</a></li>
    <li><a href="${pageContext.request.contextPath}/wallet"><i class="fas fa-wallet"></i> Wallet</a></li>
    <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Log Out</a></li>
  </ul>
</aside>

=======
    <div class="header-right">
      <div class="wallet-info">
        <h3>Wallet Balance</h3>
        <p>${userAccount.balance}</p>
        <a href="/addbalance">Add Balance</a>
      </div>
      <a href="${pageContext.request.contextPath}/profile" class="icon-btn" title="Profile">
        <i class="fas fa-user-circle"></i>
      </a>
      <a href="${pageContext.request.contextPath}/logout" class="icon-btn" title="Logout">
        <i class="fas fa-sign-out-alt"></i>
      </a>
    </div>
  </header>
>>>>>>> 1ca1e9317e1b5bb186f7e8f4d23c40416c5baeb8

  <div class="container">
    <aside>
      <ul>
        <li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>
        <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/portfolio">Portfolio</a></li>
        <li><a href="${pageContext.request.contextPath}/stocks">Stocks</a></li>
        <li><a href="${pageContext.request.contextPath}/trades">Buy/Sell</a></li>
        <li><a href="${pageContext.request.contextPath}/growthreport">Profit/Loss Report</a></li>
        <li><a href="${pageContext.request.contextPath}/transactions">Transaction</a></li>
        <li><a href="${pageContext.request.contextPath}/wallet">Wallet</a></li>
        <li><a href="${pageContext.request.contextPath}/logout">Log Out</a></li>
      </ul>
    </aside>

   <main>
   <!-- Profile Image Section -->
   <div style="text-align: center; margin-bottom: 2rem;">
    <c:choose>
        <c:when test="${not empty profileImageBase64}">
            <img src="data:image/jpeg;base64,${profileImageBase64}"
                 alt="Profile Photo"
                 style="width: 160px; height: 160px; border-radius: 50%; object-fit: cover; border: 4px solid #007bff;" />
        </c:when>
        <c:otherwise>
            <img src="${pageContext.request.contextPath}/images/defaut.jpg"
                 alt="Default Profile"
                 style="width: 160px; height: 160px; border-radius: 50%; object-fit: cover; border: 4px solid #007bff;" />
        </c:otherwise>
    </c:choose>

    
</div>

   <!-- User Information -->
   <p><strong>Name:</strong> ${userDetails.name}</p>
   <p><strong>Username:</strong> ${userDetails.username}</p>
   <p><strong>Email:</strong> ${userDetails.email}</p>
   <p><strong>Mobile:</strong> ${userDetails.mobile}</p>
   <p><strong>PAN NO:</strong> ${userDetails.pan}</p>
   <p><strong>DOB:</strong> ${userDetails.dateOfBirth}</p>
   <p><strong>Wallet Balance:</strong> ${userAccount.balance}</p>

   <!-- Edit Other Details -->
   <button><a href="${pageContext.request.contextPath}/updatepage">Edit Profile</a></button>
</main>

  </div>

  <footer>
    &copy; 2025 Trading App | All rights reserved
  </footer>
</body>
</html>
