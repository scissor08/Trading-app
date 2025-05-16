<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Stock List</title>
</head>
<body>
<h2>Available Stocks</h2>
<table border="1" cellpadding="10">
    <thead>
    <tr>
        <th>ID</th>
        <th>Symbol</th>
        <th>Name</th>
        <th>Price</th>
        <th>Quantity</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="stock" items="${stocks}">
        <tr>
            <td>${stock.id}</td>
            <td>${stock.symbol}</td>
            <td>${stock.name}</td>
            <td>${stock.price}</td>
            <td>${stock.quantity}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
