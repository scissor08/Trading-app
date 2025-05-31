<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Watchlist</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            background-color: #f8f9fa;
        }

        .table-container {
            margin: 50px auto;
            max-width: 1000px;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .btn-remove {
            color: white;
            background-color: red;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
        }

        .btn-remove:hover {
            background-color: darkred;
        }
    </style>
</head>
<body>

<div class="table-container">
    <h2>Your Watchlist</h2>
    <table class="table table-hover table-bordered" id="watchlistTable">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Symbol</th>
               
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="watchlistBody">
            <!-- Populated by AJAX -->
        </tbody>
    </table>
</div>

<script>
    // Load watchlist data
    function loadWatchlist() {
        $.ajax({
            url: '/api/watchlist',
            type: 'GET',
            success: function(data) {
                let tbody = '';
                data.forEach(item => {
                    tbody += `
                        <tr>
                            <td>${item.id}</td>
                            <td>${item.symbol}</td>
                           
                            <td><button class="btn-remove" onclick="removeFromWatchlist(${item.id})">Remove</button></td>
                        </tr>
                    `;
                });
                $('#watchlistBody').html(tbody);
            }
        });
    }

    // Remove stock from watchlist
    function removeFromWatchlist(id) {
        if (confirm("Are you sure you want to remove this stock from your watchlist?")) {
            $.ajax({
                url: `/api/watchlist/remove/${id}`,
                type: 'DELETE',
                success: function() {
                    loadWatchlist();
                }
            });
        }
    }

    // Load watchlist on page load
    $(document).ready(function() {
        loadWatchlist();
    });
</script>

</body>
</html>
