<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<style>
    * {
        box-sizing: border-box;
    }

    body, html {
        margin: 0;
        padding: 0;
        height: 100%;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    header {
        background-color: #f8f8ff;
        color: black;
        padding: 1rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: fixed;
        top: 0;
        left: 200px;
        right: 0;
        z-index: 1000;
        box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
        margin-bottom: 100px;
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
        border: 1px solid black;
        box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
    }

    .header-left button {
        padding: 0.5rem 1rem;
        background-color: #007bff;
        border: none;
        border-radius: 6px;
        color: white;
        cursor: pointer;
        box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
    }

    .wallet-info {
        background-color: #fff;
        color: #0e1c36;
        padding: 0.8rem 1.2rem;
        border-radius: 10px;
        text-align: center;
        border: 1px solid black;
        box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
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
        color: black;
        font-size: 1.5rem;
        text-decoration: none;
        transition: color 0.3s;
        box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
    }

    .icon-btn:hover {
        color: #ffc107;
    }

    aside {
        background-color: #1e2d50;
        color: white;
        width: 200px;
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        padding: 2rem 1rem;
        overflow-y: auto;
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
    padding: 15rem 3rem 2rem;
    background-color: #fff;
    overflow-y: auto;
    text-align: left;
    max-width: 600px;
    margin: 0 auto;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    border-radius: 12px;
    line-height: 2rem;
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
        padding: 1rem;
        text-align: center;
        background-color: #f8f8ff;
        color: black;
        position: relative;
        z-index: 1;
    }
</style>
</head>
<body>

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

<header>
  <div class="header-left">
    <input type="text" id="searchInput" placeholder="Search stocks">
    <button onclick="filterTable()">Search</button>
  </div>
  <h2>Welcome, ${userDetails.name}</h2>
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
</header>

<main>
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
    
    <div class="profile-details">
      <p><strong>Name:</strong> ${userDetails.name}</p>
      <p><strong>Username:</strong> ${userDetails.username}</p>
      <p><strong>Email:</strong> ${userDetails.email}</p>
      <p><strong>Mobile:</strong> ${userDetails.mobile}</p>
      <p><strong>PAN NO:</strong> ${userDetails.pan}</p>
      <p><strong>DOB:</strong> ${userDetails.dateOfBirth}</p>
      <p><strong>Wallet Balance:</strong> ${userAccount.balance}</p>
    </div>

    <div class="profile-button">
	   <button><a href="${pageContext.request.contextPath}/update">Edit Profile</a></button>
    </div>
</main>


<footer>
  &copy; 2025 Trading App | All rights reserved
</footer>

</body>
</html>
