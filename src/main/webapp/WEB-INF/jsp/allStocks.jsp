<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>All Stocks</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" />
</head>
<body>
<div class="container">
    <h1>Multiple Stocks</h1>
    <table>
        <thead>
        <tr>
            <th>Symbol</th>
            <th>Logo</th>
            <th>Price</th>
            <th>Change</th>
            <th>Change Percent</th>
            <th>Volume</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="stock" items="${stocks}">
            <tr>
                <td>${stock.symbol}</td>
                <td>
                    <img width="50" height="50"
                         src="https://logo.clearbit.com/${stock.domain}" alt="${stock.symbol} logo"
                         onerror="this.src='https://via.placeholder.com/50?text=No+Logo'"/>
                </td>
                <td>${stock.price}</td>
                <td>${stock.change}</td>
                <td>${stock.changePercent}</td>
                <td>${stock.volume}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/" class="link">Back to Search</a>
</div>
</body>
</html>
