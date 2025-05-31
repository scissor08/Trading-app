<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    flex-grow: 1;
    padding: 2rem;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    padding: 15rem 3rem 3rem;
  }

  .profile-container {
    background-color: white;
    padding: 30px 40px;
    border-radius: 12px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 500px;
  }

  .profile-container h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #333;
  }

  label {
    font-weight: bold;
    margin-top: 10px;
    display: block;
    color: #333;
  }

  input[type="text"],
  input[type="email"],
  input[type="date"],
  input[type="file"] {
    padding: 10px;
    width: 100%;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 6px;
    box-sizing: border-box;
  }

  button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px;
    width: 100%;
    border-radius: 6px;
    margin-top: 20px;
    cursor: pointer;
    font-weight: bold;
  }

  button:hover {
    background-color: #0056b3;
  }

  img {
    width: 150px;
    height: 150px;
    object-fit: cover;
    border: 2px solid #007bff;
    border-radius: 8px;
    display: block;
    margin: 10px auto;
  }


 
</style>
</head>
<body>
<jsp:include page="header.jsp" />


<main>
      <div class="profile-container">
        <h2>Edit Profile - ${userDetails.name}</h2>

        <form action="/update" method="post" enctype="multipart/form-data">
          <label>Name:</label>
          <input type="text" name="name" value="${userDetails.name}" required>

          <label>Username:</label>
          <input type="text" name="username" value="${userDetails.username}" required>

          <label>Email:</label>
          <input type="email" name="email" value="${userDetails.email}" required>

          <label>Mobile:</label>
          <input type="text" name="mobile" value="${userDetails.mobile}" required>

          <label>PAN Number:</label>
          <input type="text" name="pan" value="${userDetails.pan}" required>

          <label>Date of Birth:</label>
		  <fmt:formatDate value="${userDetails.dateOfBirth}" pattern="yyyy-MM-dd" var="formattedDob" />
		  <input type="date" name="dateOfBirth" value="${formattedDob}" required>

          <label>Profile Photo:</label>
          <img src="${userDetails.profileImage}" alt="Current Photo">
          <input type="file" name="profileImage" accept="image/*">

          <button type="submit">Update Profile</button>
        </form>
      </div>
    </main>


<jsp:include page="footer.jsp" />

</body>
</html>
