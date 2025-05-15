<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Live Stock Quote</title></head>
<body>
<h2>Live Stock Data</h2>
<c:if test="${not empty stock}">
    <p><strong>Symbol:</strong> ${stock["01. symbol"]}</p>
    <p><strong>Price:</strong> ${stock["05. price"]}</p>
    <p><strong>Change:</strong> ${stock["09. change"]}</p>
    <p><strong>Change Percent:</strong> ${stock["10. change percent"]}</p>
</c:if>


</body>
<script>
    setTimeout(() => {
        window.location.reload();
    }, 3000);
</script>

</html>
