<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>KYC Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { padding: 12px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #f2f2f2; }
        a.btn { padding: 6px 12px; background: #4CAF50; color: white; text-decoration: none; border-radius: 4px; }
        a.btn:hover { background: #45a049; }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
<h2>KYC Verification Records</h2>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>User Name</th>
            <th>Email</th>
            <th>Doc Type</th>
            <th>Decision</th>
            <th>Confidence</th>
            <th>Download PDF</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="record" items="${records}">
            <tr>
                <td>${record.id}</td>
                <td>${record.userFullName}</td>
                <td>${record.userEmail}</td>
                <td>${record.userDocType}</td>
                <td>${record.decision}</td>
                <td>${record.confidence}</td>
                <td>
                    <a href="/kyc/download/${record.id}" class="btn">Download</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>
