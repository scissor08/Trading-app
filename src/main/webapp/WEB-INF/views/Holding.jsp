<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Holdings</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
  <style>
    body, html {
      margin: 0;
      padding: 0;
      height: 100%;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
       background: white;
    }

    header {
      background-color: white;
      color: black;
      padding: 1rem 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      z-index: 1001;
      flex-wrap: wrap;
    }

    .nav-left {
      display: flex;
      align-items: center;
      gap: 1rem;
         

    }

    .back-icon {
      font-size: 1.5rem;
      color: black;
      cursor: pointer;
      text-decoration: none;
       
 
    }

    .nav-links {
      display: flex;
      gap: 1.5rem;
      align-items: center;
    }

    .icon-btn {
      color: black;
      font-size: 1.4rem;
      text-decoration: none;
      transition: color 0.2s ease;

    }

    .icon-btn:hover {
      color: #007bff;
    }

    main {
      margin-top: 80px;
      padding: 2rem;
    }

    .holdings-table {
      background-color: white;
      padding: 1rem;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      padding: 0.75rem 1rem;
      border-bottom: 1px solid #ddd;
      text-align: center;
    }

    th {
      background-color: #0e1c36;
      color: white;
    }

    tr:hover {
      background-color: #f1f1f1;
    }

    @media (max-width: 600px) {
      header {
        flex-direction: column;
        align-items: flex-start;
      }

      .nav-links {
        flex-direction: column;
        width: 100%;
        margin-top: 0.5rem;
      }
    }
  </style>
</head>
<body>
 <jsp:include page="header.jsp" />


<main>
  <h2>Your Holdings</h2>
  <div class="holdings-table">
    <table id="holdingsTable">
      <thead>
        <tr>
          <th>Symbol</th>
          <th>Quantity</th>
          <th>Buy Price</th>
          <th>Current Price</th>
          <th>Total Investment</th>
          <th>Current Value</th>
          <th>Profit / Loss</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="holding" items="${holdings}">
          <tr>
            <td>${holding.symbol}</td>
            <td>${holding.quantity}</td>
            <td>${holding.price}</td>
            <td>${holding.trancationAmount}</td>
            <td>${holding.quantity * holding.price}</td>
            <td>${holding.quantity * holding.trancationAmount}</td>
            <td>
              <c:choose>
                <c:when test="${(holding.trancationAmount - holding.price) >= 0}">
                  <span style="color: green;">+ ${((holding.trancationAmount - holding.price) * holding.quantity)}</span>
                </c:when>
                <c:otherwise>
                  <span style="color: red;">- ${((holding.price - holding.trancationAmount) * holding.quantity)}</span>
                </c:otherwise>
              </c:choose>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</main>

 <jsp:include page="footer.jsp" />

</body>
</html>
