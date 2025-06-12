<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <title>All Stocks</title>
  <style>
    body {
        margin: 0;
        padding: 20px;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f5f7fa;
        color: #0e1c36;
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #0e1c36;
    }

    table {
        width: 90%;
        margin: 0 auto;
        border-collapse: collapse;
        background-color: #ffffff;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        border-radius: 12px;
        overflow: hidden;
    }

    th, td {
        border: 1px solid #ccc;
        padding: 12px 15px;
        text-align: center;
        color: #0e1c36;
    }

    th {
        background-color: #0e1c36;
        color: #ffffff;
        font-weight: 600;
    }

    tr:nth-child(even) {
        background-color: #f9fafb; /* subtle alternate row color */
    }

    a {
        color: #ff7f00;
        text-decoration: none;
        font-weight: bold;
    }

    a:hover {
        text-decoration: underline;
        color: #e66900;
    }

    img.logo {
        width: 30px;
        height: 30px;
        vertical-align: middle;
        border-radius: 8px;
        border: 1px solid #ccc;
    }

    .positive {
        color: #4caf50; /* green */
        font-weight: 600;
    }

    .negative {
        color: #e53935; /* red */
        font-weight: 600;
    }

    .neutral {
        color: #0e1c36; /* navy blue */
    }
</style>

</head>
<body>
   <jsp:include page="header.jsp" /> 
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
            <fmt:parseNumber var="changeVal" value="${stock.change}" type="number" />
            <fmt:parseNumber var="changePercentVal" value="${stock.changePercent}" type="number" />
            <fmt:parseNumber var="priceVal" value="${stock.price}" type="number" />
            <fmt:parseNumber var="openVal" value="${stock.open}" type="number" />
            <fmt:parseNumber var="highVal" value="${stock.high}" type="number" />
            <fmt:parseNumber var="lowVal" value="${stock.low}" type="number" />
            <fmt:parseNumber var="prevCloseVal" value="${stock.previousClose}" type="number" />
            <tr>
                <td>
                    <img class="logo" 
                         src="https://logo.clearbit.com/${stock.domain}" 
                         alt="${stock.symbol} logo" 
                         onerror="this.onerror=null; this.src='default-logo.png';" />
                </td>
                <td><a href="${pageContext.request.contextPath}/stock/${stock.symbol}">${stock.symbol}</a></td>
                <td><fmt:formatNumber value="${priceVal}" type="number" pattern="0.00" /></td>
                <td>
                    <c:choose>
                        <c:when test="${changeVal > 0}">
                            <span class="positive"><fmt:formatNumber value="${changeVal}" pattern="0.00" /></span>
                        </c:when>
                        <c:when test="${changeVal < 0}">
                            <span class="negative"><fmt:formatNumber value="${changeVal}" pattern="0.00" /></span>
                        </c:when>
                        <c:otherwise>
                            <span class="neutral"><fmt:formatNumber value="${changeVal}" pattern="0.00" /></span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${changePercentVal > 0}">
                            <span class="positive"><fmt:formatNumber value="${changePercentVal}" pattern="0.00" /></span>
                        </c:when>
                        <c:when test="${changePercentVal < 0}">
                            <span class="negative"><fmt:formatNumber value="${changePercentVal}" pattern="0.00" /></span>
                        </c:when>
                        <c:otherwise>
                            <span class="neutral"><fmt:formatNumber value="${changePercentVal}" pattern="0.00" /></span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><fmt:formatNumber value="${openVal}" type="number" pattern="0.00" /></td>
                <td><fmt:formatNumber value="${highVal}" type="number" pattern="0.00" /></td>
                <td><fmt:formatNumber value="${lowVal}" type="number" pattern="0.00" /></td>
                <td><fmt:formatNumber value="${prevCloseVal}" type="number" pattern="0.00" /></td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<jsp:include page="footer.jsp" />
</body>
</html>
