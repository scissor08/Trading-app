<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!-- Header matching the screenshot design -->
<header>
    <div class="header-left">
        <input type="text" id="searchInput" placeholder="Search stocks">
        <button onclick="filterTable()">Search</button>
    </div>
    <div class="header-right">
        <div class="header-nav-links">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link" data-target="dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/wallet" class="nav-link" data-target="wallet">Wallet</a>
            <a href="${pageContext.request.contextPath}/profile" class="nav-link" data-target="profile">Profile</a>
        </div>
        <div class="header-icons">
            <a href="${pageContext.request.contextPath}/profile" class="icon-btn" title="Profile">
                <i class="fas fa-user-circle"></i>
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="icon-btn" title="Logout">
                <i class="fas fa-sign-out-alt"></i>
            </a>
        </div>
    </div>
</header>

<!-- CSS styles matching the screenshot -->
<style>
header {
    background-color: #f8f9fa;
    padding: 0.75rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 70px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    z-index: 1000;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    width: 100%;
    border-bottom: 1px solid #e0e0e0;
}

.header-left {
    display: flex;
    gap: 0.5rem;
    align-items: center;
}

.header-left input[type="text"] {
    padding: 0.5rem 0.75rem;
    border-radius: 4px;
    border: 1px solid #ced4da;
    min-width: 200px;
    font-size: 0.9rem;
    background-color: white;
}

.header-left input[type="text"]:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
}

.header-left button {
    padding: 0.5rem 1rem;
    background-color: #007bff;
    border: none;
    color: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.9rem;
    font-weight: 500;
}

.header-left button:hover {
    background-color: #0056b3;
}

.header-right {
    display: flex;
    align-items: center;
    gap: 2rem;
}

.header-nav-links {
    display: flex;
    gap: 2rem;
    align-items: center;
}

.header-nav-links a {
    text-decoration: none;
    color: #333;
    font-weight: 500;
    font-size: 0.95rem;
    transition: color 0.3s ease;
    padding: 0.5rem 0;
}

.header-nav-links a:hover {
    color: #007bff;
}

.header-icons {
    display: flex;
    gap: 1rem;
    align-items: center;
}

.icon-btn {
    color: #333;
    font-size: 1.3rem;
    text-decoration: none;
    transition: color 0.3s ease;
}

.icon-btn:hover {
    color: #007bff;
}

/* Add margin to body to account for fixed header */
body {
    margin-top: 70px;
    background-color: #f5f5f5;
}

/* Responsive design */
@media (max-width: 768px) {
    header {
        padding: 0.5rem 1rem;
        height: auto;
        flex-wrap: wrap;
        gap: 1rem;
    }
    
    .header-left {
        width: 100%;
        justify-content: center;
    }
    
    .header-right {
        width: 100%;
        justify-content: space-between;
    }
    
    .header-nav-links {
        gap: 1rem;
    }
    
    .header-left input[type="text"] {
        min-width: 150px;
    }
}
</style>