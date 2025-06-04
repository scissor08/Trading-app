<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WalletPage</title>

<!-- FontAwesome CDN for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f7f9;
    }

  main {
        margin-left: 220px;
        padding: 2rem;
    }

    main form {
        background-color: #fff;
        padding: 2rem;
        border-radius: 12px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        max-width: 500px;
    }

    main h3 {
        margin-top: 0;
        font-size: 1.5rem;
        color: #333;
    }

    main p {
        font-size: 1.8rem;
        font-weight: bold;
        color: #007bff;
    }

    button {
        margin-top: 1rem;
        padding: 0.8rem 1.2rem;
        background-color: #007bff;
        border: none;
        border-radius: 8px;
        color: white;
        font-size: 1rem;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    button:hover {
        background-color: #0056b3;
    }

    button a {
        color: white;
        text-decoration: none;
        display: block;
        width: 100%;
        height: 100%;
    }


 
</style>

</head>
<body>
<jsp:include page="header.jsp" />
<div>
  



   <main>
        <form>
           <h3>Your Balance</h3>
           <p>${balance}</p>
           <button><a href="/addbalance">Add Balance</a></button>
       </form> 
   </main>
  

  <jsp:include page="footer.jsp" />
</div>
</body>
</html>
