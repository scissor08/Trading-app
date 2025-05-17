<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Search Stock</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" />
</head>
<body>
<div class="container">
    <h1>Search Stock</h1>
    <form action="${pageContext.request.contextPath}/getStock" method="post" class="form">
        <label>Enter Stock Symbol:</label>
        <input type="text" name="symbol" required placeholder="e.g. AAPL"/>
        <button type="submit">Get Stock</button>
    </form>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <p><a href="${pageContext.request.contextPath}/stocks" class="link">View Multiple Stocks</a></p>
</div>
</body>
</html>
