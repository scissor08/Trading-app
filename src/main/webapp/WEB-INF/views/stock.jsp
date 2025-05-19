<html>
<head>
    <title>Stock Search</title>
    <style>
        body {
            background-color: black;
            color: orange;
            font-family: Arial, sans-serif;
            padding: 50px;
            text-align: center;
        }
        h2 {
            margin-bottom: 30px;
        }
        input[type="text"] {
            padding: 10px;
            width: 250px;
            border: 2px solid orange;
            background-color: #111;
            color: orange;
            font-size: 16px;
            border-radius: 4px;
        }
        input[type="submit"] {
            padding: 10px 25px;
            background-color: orange;
            border: none;
            color: black;
            font-weight: bold;
            cursor: pointer;
            border-radius: 4px;
            margin-left: 10px;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #cc7000;
        }
        .error {
            color: red;
            margin-top: 20px;
        }
        .result-link {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Search for a Stock Symbol</h2>
    <form action="${pageContext.request.contextPath}/getStock" method="post">
        <input type="text" name="symbol" placeholder="Enter stock symbol (e.g. AAPL)" required />
        <input type="submit" value="Get Stock" />
    </form>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <div class="result-link">
        <a href="${pageContext.request.contextPath}/stocks" style="color: orange; text-decoration: underline;">
            View All Stocks
        </a>
    </div>
</body>
</html>
