<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stock Watchlist</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .container {
            margin-top: 20px;
        }

        .btn-remove {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-remove:hover {
            background-color: #c82333;
        }

        .table {
            margin-top: 20px;
        }

        .alert {
            margin-top: 20px;
        }

        /* Utility classes for show/hide */
        .d-none {
            display: none !important;
        }

        .d-block {
            display: block !important;
        }

        .d-table {
            display: table !important;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h1 class="mb-4">My Stock Watchlist</h1>

                <div id="noDataMessage" class="alert alert-info d-none" role="alert">
                    <i class="bi bi-info-circle"></i>
                    No stocks in your watchlist yet. Add some stocks to get started!
                </div>

                <div id="watchlistTable" class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Symbol</th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="watchlistBody">
                        </tbody>
                    </table>
                </div>

                <div id="loadingMessage" class="text-center d-none">
                    <div class="spinner-border" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-2">Loading watchlist...</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            console.log("DOM Content Loaded. Attempting to fetch watchlist.");
            fetchWatchlist();
        });

        function fetchWatchlist() {
            const loadingMessage = document.getElementById("loadingMessage");
            if (loadingMessage) loadingMessage.classList.remove("d-none");

            document.getElementById("noDataMessage").classList.add("d-none");
            document.getElementById("watchlistTable").classList.add("d-none");

            fetch("/api/watchlist")
                .then(response => {
                    if (!response.ok) {
                        return response.json().then(errorData => {
                            throw new Error(errorData.message || "Failed to fetch watchlist.");
                        });
                    }
                    return response.json();
                })
                .then(data => {
                    if (loadingMessage) loadingMessage.classList.add("d-none");

                    const tbody = document.getElementById("watchlistBody");
                    const noDataMessage = document.getElementById("noDataMessage");
                    const watchlistTable = document.getElementById("watchlistTable");

                    if (!tbody || !noDataMessage || !watchlistTable) {
                        Swal.fire("Error", "Page elements not found. Please check HTML structure.", "error");
                        return;
                    }

                    tbody.innerHTML = ""; // Clear existing rows

                    if (!Array.isArray(data) || data.length === 0) {
                        noDataMessage.classList.remove("d-none");
                        watchlistTable.classList.add("d-none");
                    } else {
                        noDataMessage.classList.add("d-none");
                        watchlistTable.classList.remove("d-none");

                        data.forEach(item => {
                            if (item && item.id != null && item.symbol) {
                                const row = document.createElement("tr");
                                row.setAttribute("data-id", String(item.id));

                                const idCell = document.createElement("td");
                                idCell.textContent = item.id;

                                const symbolCell = document.createElement("td");
                                symbolCell.textContent = item.symbol;
                                symbolCell.style.cursor = "pointer";
                                symbolCell.style.textDecoration = "underline";
                                symbolCell.style.color = "#0d6efd";
                                symbolCell.addEventListener("click", function () {
                                    window.location.href = "stocks";
                                });

                                const actionCell = document.createElement("td");
                                const deleteButton = document.createElement("button");
                                deleteButton.className = "btn-remove";
                                deleteButton.setAttribute("data-stock-id", String(item.id));

                                const icon = document.createElement("i");
                                icon.className = "bi bi-trash";
                                deleteButton.appendChild(icon);

                                deleteButton.addEventListener("click", function (e) {
                                    e.preventDefault();
                                    const stockId = this.getAttribute("data-stock-id");
                                    removeStock(parseInt(stockId, 10));
                                });

                                actionCell.appendChild(deleteButton);
                                row.appendChild(idCell);
                                row.appendChild(symbolCell);
                                row.appendChild(actionCell);
                                tbody.appendChild(row);
                            }
                        });
                    }
                })
                .catch(error => {
                    if (loadingMessage) loadingMessage.classList.add("d-none");
                    Swal.fire("Error", "Failed to load watchlist: " + error.message, "error");
                    document.getElementById("noDataMessage").classList.remove("d-none");
                    document.getElementById("watchlistTable").classList.add("d-none");
                });
        }

        function removeStock(id) {
            const stockIdString = String(id);

            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    fetch("/api/watchlist/remove/" + id, {
                        method: "DELETE"
                    })
                    .then(response => {
                        if (response.ok) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Removed!',
                                text: 'Stock removed from watchlist.',
                                timer: 1500,
                                showConfirmButton: false
                            }).then(() => {
                                const rowToRemove = document.querySelector('#watchlistBody tr[data-id="' + stockIdString + '"]');
                                if (rowToRemove) {
                                    rowToRemove.remove();
                                }

                                const tbody = document.getElementById("watchlistBody");
                                if (tbody && tbody.children.length === 0) {
                                    document.getElementById("noDataMessage").classList.remove("d-none");
                                    document.getElementById("watchlistTable").classList.add("d-none");
                                }
                            });
                        } else {
                            return response.text().then(errorMessage => {
                                throw new Error(errorMessage || "Delete failed.");
                            });
                        }
                    })
                    .catch(error => {
                        Swal.fire("Error", "Failed to remove stock: " + error.message, "error");
                    });
                }
            });
        }
    </script>
</body>
</html>
