<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AddBalancePage</title>

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


    h2 {
        margin: 0;
        font-size: 1.4rem;
    }



    main {
        margin-left: 220px;
        padding: 2rem;
        transition: margin-left 0.3s ease;
    }

    .balance-form-container {
        background-color: white;
        border-radius: 10px;
        padding: 2rem;
        max-width: 500px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        margin: 2rem auto;
        text-align: center;
    }

    .balance-form-container h3 {
        margin-bottom: 1.5rem;
        color: #0e1c36;
    }

    .balance-form-container input[type="number"] {
        padding: 0.6rem;
        border-radius: 6px;
        border: 1px solid #ccc;
        width: 100%;
        max-width: 300px;
        margin-bottom: 1.5rem;
        font-size: 1rem;
    }

    .balance-form-container button {
        padding: 0.6rem 1.2rem;
        background-color: #ff7f00;
        border: none;
        border-radius: 6px;
        color: white;
        font-size: 1rem;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .balance-form-container button:hover {
        background-color: #e66900;
    }


</style>

</head>
<body>

<div>
 <jsp:include page="header.jsp" />

   <main id="mainContent">
       <div class="balance-form-container">
           <h3>Enter Amount to Add</h3>
           <form action="${pageContext.request.contextPath}/add" method="post">
               <input type="number" name="cash" placeholder="Enter amount" required />
               <br>
               <button type="submit">Add Cash</button>
           </form>
       </div>
   </main>

  <jsp:include page="footer.jsp" />
</div>

<script>
    const hamburgerBtn = document.getElementById('hamburgerBtn');
    const sidebar = document.getElementById('sidebar');

    hamburgerBtn.addEventListener('click', () => {
        sidebar.classList.toggle('active');
    });
</script>

</body>
</html>
