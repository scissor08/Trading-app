<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    * {
        box-sizing: border-box;
    }

    body, html {
        margin: 0;
        padding: 0;
        height: 100%;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

main {
    padding: 15rem 3rem 2rem;
    background-color: #fff;
    overflow-y: auto;
    text-align: left;
    max-width: 600px;
    margin: 0 auto;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    border-radius: 12px;
    line-height: 2rem;
}

main p {
    font-size: 1.15rem;
    margin-bottom: 1.2rem;
}

main p strong {
    display: inline-block;
    width: 160px;
    color: #0e1c36;
}

main button {
    background-color: #007bff;
    border: none;
    padding: 10px 20px;
    border-radius: 25px;
    font-size: 1rem;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin-top: 1rem;
}
   
</style>
</head>
<body>
<jsp:include page="header.jsp" />
<main>
  <div style="text-align: center; margin-bottom: 2rem;">
    <c:choose>
        <c:when test="${not empty profileImageBase64}">
            <img src="data:image/jpeg;base64,${profileImageBase64}"
                 alt="Profile Photo"
                 style="width: 160px; height: 160px; border-radius: 50%; object-fit: cover; border: 4px solid #007bff;" />
        </c:when>
        <c:otherwise>
            <img src="${pageContext.request.contextPath}/images/defaut.jpg"
                 alt="Default Profile"
                 style="width: 160px; height: 160px; border-radius: 50%; object-fit: cover; border: 4px solid #007bff;" />
        </c:otherwise>
    </c:choose>
</div>
    
    <div class="profile-details">
      <p><strong>Name:</strong> ${userDetails.name}</p>
      <p><strong>Username:</strong> ${userDetails.username}</p>
      <p><strong>Email:</strong> ${userDetails.email}</p>
      <p><strong>Wallet Balance:</strong> ${userAccount.balance}</p>
    </div>

</main>


<jsp:include page="footer.jsp" />

</body>
</html>
