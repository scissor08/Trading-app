<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Stock Result</title>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" />
</head>
<body>
<div class="container">
    <h1>Stock Details for ${stock.symbol}</h1>
    <table>
        <tr><th>Open</th><td>${stock.open}</td></tr>
        <tr><th>High</th><td>${stock.high}</td></tr>
        <tr><th>Low</th><td>${stock.low}</td></tr>
        <tr><th>Price</th><td>${stock.price}</td></tr>
        <tr><th>Volume</th><td>${stock.volume}</td></tr>
        <tr><th>Latest Trading Day</th><td>${stock.latestTradingDay}</td></tr>
        <tr><th>Previous Close</th><td>${stock.previousClose}</td></tr>
        <tr><th>Change</th><td>${stock.change}</td></tr>
        <tr><th>Change Percent</th><td>${stock.changePercent}</td></tr>
    </table>

    <a href="${pageContext.request.contextPath}/viewstock" class="link">Back to Search</a>
</div>
</body>
</html>
