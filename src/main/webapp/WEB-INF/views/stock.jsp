<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Stock Search</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            color: #0e1c36;
            text-align: center;
        }

        main {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 90vh;
            padding: 20px;
        }

        form {
            background-color: #ffffff;
            padding: 2rem 3rem;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        h2 {
            margin-bottom: 1.5rem;
            color: #0e1c36;
        }

        input[type="text"] {
            width: 100%;
            padding: 0.7rem;
            margin-top: 0.3rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
            font-size: 1rem;
            transition: border-color 0.3s;
            color: #0e1c36;
        }

        input[type="text"]:focus {
            border-color: #ff7f00;
        }

        input[type="submit"] {
            margin-top: 1.5rem;
            width: 100%;
            padding: 0.8rem;
            background-color: #ff7f00;
            color: white;
            font-size: 1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #e66900;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-top: 20px;
        }

        .result-link {
            margin-top: 20px;
        }

        .result-link a {
            color: #ff7f00;
            text-decoration: underline;
            font-weight: bold;
            transition: color 0.3s;
        }

        .result-link a:hover {
            color: #e66900;
        }
    </style>

</head>
<body>

<main>
    <form action="${pageContext.request.contextPath}/getStock" method="post">
        <h2>Search for a Stock Symbol</h2>
        <input type="text" name="symbol" placeholder="Enter stock symbol (e.g. AAPL)" required />
        <input type="submit" value="Get Stock" />

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <div class="result-link">
            <a href="${pageContext.request.contextPath}/stocks">View All Stocks</a>
        </div>
    </form>
</main>
</body>
</html>
