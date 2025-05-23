<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Holdings</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { padding: 10px; text-align: center; border: 1px solid #ddd; }
        th { background-color: #333; color: white; }
    </style>
</head>
<body>
    <h2>Your Holdings</h2>
    <c:if test="${empty holdings}">
        <p>No holdings found.</p>
    </c:if>
    <c:if test="${not empty holdings}">
        <table>
            <tr>
                <th>Stock</th>
                <th>Quantity</th>
                <th>Buy Price</th>
                <th>Current Price</th>
                <th>Total Invested</th>
                <th>Current Value</th>
                <th>Gain/Loss</th>
            </tr>
            <c:forEach var="h" items="${holdings}">
                <tr>
                    <td>${h.symbol}</td>
                    <td>${h.quantity}</td>
                    <td>${h.buyPrice}</td>
                    <td>${h.currentPrice}</td>
                    <td>${h.quantity * h.buyPrice}</td>
                    <td>${h.quantity * h.currentPrice}</td>
                    <c:set var="gain" value="${h.quantity * (h.currentPrice - h.buyPrice)}"/>
                    <td style="color: ${gain >= 0 ? 'green' : 'red'};">₹${gain}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</body>
</html>
