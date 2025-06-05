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
    padding: 5rem 3rem 2rem;
    background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
    overflow-y: auto;
    text-align: left;
    max-width: 100%;
    box-shadow: 0 8px 32px rgba(0,0,0,0.08);
    border-radius: 20px;
    line-height: 2.2rem;
    position: relative;
}

main::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, #007bff, #0056b3);
    border-radius: 20px 20px 0 0;
}

main p {
    font-size: 1.2rem;
    margin-bottom: 1.8rem;
    padding: 0.8rem 0;
    transition: all 0.3s ease;
    border-bottom: 1px solid rgba(0,123,255,0.1);
    position: relative;
}

main p:hover {
    transform: translateX(8px);
    color: #0056b3;
}

main p strong {
    display: inline-block;
    width: 160px;
    color: #0e1c36;
    font-weight: 600;
    position: relative;
}

main p strong::after {
    content: '';
    position: absolute;
    bottom: -2px;
    left: 0;
    width: 0;
    height: 2px;
    background: linear-gradient(90deg, #007bff, #0056b3);
    transition: width 0.4s ease;
}

main p:hover strong::after {
    width: 90%;
}

/* Profile image styling */
div[style*="text-align: center"] {
    text-align: center !important;
    margin-bottom: 3rem !important;
    position: relative;
}

div[style*="text-align: center"]::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 200px;
    height: 200px;
    background: radial-gradient(circle, rgba(0,123,255,0.1) 0%, transparent 70%);
    border-radius: 50%;
    animation: profileGlow 4s ease-in-out infinite;
}

@keyframes profileGlow {
    0%, 100% {
        transform: translate(-50%, -50%) scale(1);
        opacity: 0.6;
    }
    50% {
        transform: translate(-50%, -50%) scale(1.15);
        opacity: 0.2;
    }
}

div[style*="text-align: center"] img {
    width: 180px !important;
    height: 180px !important;
    border-radius: 50% !important;
    object-fit: cover !important;
    border: 5px solid #007bff !important;
    box-shadow: 0 12px 30px rgba(0,123,255,0.25) !important;
    transition: all 0.4s ease !important;
    position: relative !important;
    z-index: 2 !important;
}

div[style*="text-align: center"]:hover img {
    transform: scale(1.08);
    box-shadow: 0 16px 40px rgba(0,123,255,0.35) !important;
    border-color: #0056b3 !important;
}

.profile-details {
    margin-top: 2rem;
    padding: 1rem 0;
}

main button {
    background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
    border: none;
    padding: 14px 28px;
    border-radius: 30px;
    font-size: 1.1rem;
    color: white;
    cursor: pointer;
    transition: all 0.3s ease;
    margin-top: 2rem;
    box-shadow: 0 6px 20px rgba(0,123,255,0.3);
    position: relative;
    overflow: hidden;
    font-weight: 500;
    letter-spacing: 0.5px;
}

main button::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
    transition: left 0.6s ease;
}

main button:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 30px rgba(0,123,255,0.4);
}

main button:hover::before {
    left: 100%;
}

main button:active {
    transform: translateY(-1px);
}

/* Enhanced typography */
main p:nth-child(odd) {
    background: rgba(0,123,255,0.02);
    border-radius: 8px;
    padding: 1rem 1.2rem;
    margin: 0.5rem -1.2rem 1.8rem;
}

main p:nth-child(even) {
    padding-left: 0.5rem;
}

/* Responsive design */
@media (max-width: 768px) {
    main {
        margin: 0 1rem;
        max-width: 95%;
        padding: 12rem 2rem 2rem;
    }
    
    main p strong {
        width: 130px;
    }
    
    div[style*="text-align: center"] img {
        width: 150px !important;
        height: 150px !important;
    }
    
    div[style*="text-align: center"]::before {
        width: 170px;
        height: 170px;
    }
}

@media (max-width: 480px) {
    main {
        margin: 0 0.5rem;
        padding: 10rem 1.5rem 2rem;
    }
    
    main p {
        font-size: 1.1rem;
        line-height: 1.8rem;
    }
    
    main p strong {
        width: 110px;
        display: block;
        margin-bottom: 0.3rem;
    }
    
    div[style*="text-align: center"] img {
        width: 130px !important;
        height: 130px !important;
    }
    
    div[style*="text-align: center"]::before {
        width: 150px;
        height: 150px;
    }
    
    main p:nth-child(odd) {
        margin: 0.5rem -1rem 1.5rem;
        padding: 0.8rem 1rem;
    }
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
    
    <div class="profile-detail">
      <p><strong>Name:</strong> ${kyc.userFullName}</p>
      <p><strong>Username:</strong> ${userDetails.username}</p>
      <p><strong>Email:</strong> ${kyc.userEmail}</p>
      <p><strong>Gender :</strong> ${kyc.userGender}</p>
      <p><strong>Mobile :</strong> ${kyc.userMobile}</p>
      <p><strong>DOB :</strong> ${kyc.userDob}</p>
      <p><strong>Adress:</strong> ${kyc.userAddress}</p> 
       <p><strong>Nationality :</strong> ${kyc.userNationality}</p>
      
    </div>

</main>


<jsp:include page="footer.jsp" />

</body>
</html>