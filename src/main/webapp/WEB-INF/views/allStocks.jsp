<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>All Stocks</title>
    <style>
        body {
            background-color: black;
            color: orange;
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 90%;
            margin: 0 auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid orange;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #222;
        }
        tr:nth-child(even) {
            background-color: #111;
        }
        a {
            color: orange;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
        img.logo {
            width: 30px;
            height: 30px;
            vertical-align: middle;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<h2>All Stocks</h2>
<table>
    <thead>
        <tr>
            <th>Logo</th>
            <th>Symbol</th>
            <th>Price</th>
            <th>Change</th>
            <th>Change Percent</th>
            <th>Open</th>
            <th>High</th>
            <th>Low</th>
            <th>Previous Close</th>
           
        </tr>
    </thead>
    <tbody>
        <c:forEach var="stock" items="${stocks}">
            <tr>
                <td>
                  <img class="logo" 
                       src="https://logo.clearbit.com/${stock.domain}" 
                       alt="${stock.symbol} logo" 
                       onerror="this.onerror=null; this.src='default-logo.png';" />
                </td>
                <td><a href="${pageContext.request.contextPath}/stock/${stock.symbol}">${stock.symbol}</a></td>
                <td>${stock.price}</td>
                <td>${stock.change}</td>
                <td>${stock.changePercent}</td>
                <td>${stock.open}</td>
                <td>${stock.high}</td>
                <td>${stock.low}</td>
                <td>${stock.previousClose}</td>
                
            </tr>
        </c:forEach>
    </tbody>
</table>
</body>
</html>
