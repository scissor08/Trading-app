<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!-- Professional Responsive Header -->
<header class="main-header">
    <div class="header-container">
        <!-- Logo Section -->
        <div class="header-logo">
            <a href="${pageContext.request.contextPath}/dashboard" class="logo-link">
                <i class="fas fa-chart-line logo-icon"></i>
                <span class="logo-text">StockTrader</span>
            </a>
        </div>

        <!-- Navigation Links -->
        <nav class="header-nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>

            <a href="${pageContext.request.contextPath}/wallet" class="nav-link">
                <i class="fas fa-wallet"></i>
                <span>Wallet</span>
        
            <a href="${pageContext.request.contextPath}/stocks" class="nav-link">
                <i class="fas fa-chart-bar"></i>
                <span>Stocks</span>
            </a>
        </nav>

        <!-- Right Section: Search + Profile -->
        <div class="header-right">
            <!-- Search Section -->
            <div class="search-container">
                <div class="search-box">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" id="searchInput" placeholder="Search stocks..." class="search-input">
                    <button type="button" onclick="filterTable()" class="search-btn">
                        <i class="fas fa-arrow-right"></i>
                    </button>
                </div>
            </div>

            <!-- Profile Dropdown -->
            <div class="profile-dropdown">
                <button class="profile-btn" onclick="toggleProfileDropdown()">
                    <i class="fas fa-user-circle profile-icon"></i>
                    <i class="fas fa-chevron-down dropdown-arrow"></i>
                </button>
                <div class="dropdown-menu" id="profileDropdown">
                    <a href="${pageContext.request.contextPath}/watchlist" class="dropdown-item">
                        <i class="fas fa-eye"></i>
                        <span>Watchlist</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/stocks" class="dropdown-item">
                        <i class="fas fa-chart-line"></i>
                        <span>My Stocks</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">
                        <i class="fas fa-user-cog"></i>
                        <span>Profile Settings</span>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="${pageContext.request.contextPath}/arise/logout" class="dropdown-item logout-item">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                </div>
            </div>

            <!-- Mobile Menu Toggle -->
            <button class="mobile-menu-btn" onclick="toggleMobileMenu()">
                <i class="fas fa-bars"></i>
            </button>
        </div>
    </div>

    <!-- Mobile Navigation Menu -->
    <div class="mobile-nav" id="mobileNav">
        <a href="${pageContext.request.contextPath}/dashboard" class="mobile-nav-item">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/wallet" class="mobile-nav-item">
            <i class="fas fa-wallet"></i>
            <span>Wallet</span>
        </a>
        <a href="${pageContext.request.contextPath}/stocks" class="mobile-nav-item">
            <i class="fas fa-chart-bar"></i>
            <span>Stocks</span>
        </a>
        <div class="mobile-search">
            <div class="search-box">
                <i class="fas fa-search search-icon"></i>
                <input type="text" placeholder="Search stocks..." class="search-input">
                <button type="button" class="search-btn">
                    <i class="fas fa-arrow-right"></i>
                </button>
            </div>
        </div>
    </div>
</header>

<!-- Overlay for dropdown -->
<div class="dropdown-overlay" id="dropdownOverlay" onclick="closeAllDropdowns()"></div>

<style>
/* Reset and base styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    margin-top: 70px;
    background-color: #f5f5f5;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* Main Header */
.main-header {
    background-color: #f8f9fa;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    width: 100%;
    height: 70px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    z-index: 1000;
    border-bottom: 1px solid #e0e0e0;
}

.header-container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 100%;
    padding: 0 2rem;
    max-width: 1400px;
    margin: 0 auto;
}

/* Logo Section */
.header-logo {
    flex-shrink: 0;
}

.logo-link {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: #333;
    font-weight: 700;
    font-size: 1.2rem;
    transition: color 0.3s ease;
}

.logo-link:hover {
    color: #007bff;
}

.logo-icon {
    font-size: 1.8rem;
    margin-right: 0.5rem;
    color: #007bff;
}

.logo-text {
    font-weight: 700;
    letter-spacing: -0.5px;
}

/* Navigation */
.header-nav {
    display: flex;
    align-items: center;
    gap: 2rem;
    flex-grow: 1;
    justify-content: center;
}

.nav-link {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    text-decoration: none;
    color: #333;
    font-weight: 500;
    font-size: 0.95rem;
    padding: 0.5rem 1rem;
    border-radius: 6px;
    transition: all 0.3s ease;
    white-space: nowrap;
}

.nav-link:hover {
    color: #007bff;
    background-color: rgba(0, 123, 255, 0.1);
}

.nav-link i {
    font-size: 1rem;
}

/* Right Section */
.header-right {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    flex-shrink: 0;
}

/* Search Container */
.search-container {
    position: relative;
}

.search-box {
    display: flex;
    align-items: center;
    background: white;
    border: 1px solid #ced4da;
    border-radius: 25px;
    padding: 0.4rem 0.8rem;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.search-box:focus-within {
    border-color: #007bff;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
}

.search-icon {
    color: #6c757d;
    font-size: 0.9rem;
    margin-right: 0.5rem;
}

.search-input {
    border: none;
    outline: none;
    background: transparent;
    font-size: 0.9rem;
    width: 200px;
    color: #333;
}

.search-input::placeholder {
    color: #6c757d;
}

.search-btn {
    background: #007bff;
    border: none;
    color: white;
    padding: 0.3rem 0.6rem;
    border-radius: 50px;
    cursor: pointer;
    margin-left: 0.5rem;
    transition: background-color 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
}

.search-btn:hover {
    background: #0056b3;
}

.search-btn i {
    font-size: 0.8rem;
}

/* Profile Dropdown */
.profile-dropdown {
    position: relative;
}

.profile-btn {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    background: none;
    border: none;
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 6px;
    transition: background-color 0.3s ease;
    color: #333;
}

.profile-btn:hover {
    background-color: rgba(0, 123, 255, 0.1);
}

.profile-icon {
    font-size: 1.8rem;
    color: #007bff;
}

.dropdown-arrow {
    font-size: 0.8rem;
    transition: transform 0.3s ease;
}

.profile-btn.active .dropdown-arrow {
    transform: rotate(180deg);
}

.dropdown-menu {
    position: absolute;
    top: calc(100% + 0.5rem);
    right: 0;
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
    min-width: 200px;
    opacity: 0;
    visibility: hidden;
    transform: translateY(-10px);
    transition: all 0.3s ease;
    z-index: 1001;
}

.dropdown-menu.show {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.dropdown-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.75rem 1rem;
    text-decoration: none;
    color: #333;
    font-size: 0.9rem;
    transition: background-color 0.3s ease;
    border-radius: 0;
}

.dropdown-item:hover {
    background-color: #f8f9fa;
}

.dropdown-item i {
    font-size: 1rem;
    width: 16px;
    text-align: center;
}

.dropdown-divider {
    height: 1px;
    background-color: #e0e0e0;
    margin: 0.5rem 0;
}

.logout-item {
    color: #dc3545;
}

.logout-item:hover {
    background-color: rgba(220, 53, 69, 0.1);
}

/* Mobile Menu Button */
.mobile-menu-btn {
    display: none;
    background: none;
    border: none;
    font-size: 1.2rem;
    color: #333;
    cursor: pointer;
    padding: 0.5rem;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

.mobile-menu-btn:hover {
    background-color: rgba(0, 123, 255, 0.1);
}

/* Mobile Navigation */
.mobile-nav {
    display: none;
    background: white;
    border-top: 1px solid #e0e0e0;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.mobile-nav-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem 2rem;
    text-decoration: none;
    color: #333;
    font-weight: 500;
    border-bottom: 1px solid #f0f0f0;
    transition: background-color 0.3s ease;
}

.mobile-nav-item:hover {
    background-color: #f8f9fa;
}

.mobile-nav-item:last-child {
    border-bottom: none;
}

.mobile-search {
    padding: 1rem 2rem;
    border-top: 1px solid #e0e0e0;
}

/* Dropdown Overlay */
.dropdown-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: transparent;
    z-index: 999;
    display: none;
}

.dropdown-overlay.show {
    display: block;
}

/* Responsive Design */
@media (max-width: 1024px) {
    .header-container {
        padding: 0 1.5rem;
    }
    
    .search-input {
        width: 150px;
    }
    
    .header-nav {
        gap: 1.5rem;
    }
}

@media (max-width: 768px) {
    .header-nav {
        display: none;
    }
    
    .search-container {
        display: none;
    }
    
    .mobile-menu-btn {
        display: block;
    }
    
    .mobile-nav.show {
        display: block;
    }
    
    .header-container {
        padding: 0 1rem;
    }
    
    .logo-text {
        display: none;
    }
    
    body {
        margin-top: 70px;
    }
}

@media (max-width: 480px) {
    .header-container {
        padding: 0 0.75rem;
    }
    
    .header-right {
        gap: 1rem;
    }
    
    .search-box {
        padding: 0.3rem 0.6rem;
    }
    
    .mobile-nav-item,
    .mobile-search {
        padding: 0.75rem 1rem;
    }
}

/* Animation for smooth transitions */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.dropdown-menu.show {
    animation: fadeInUp 0.3s ease;
}
</style>

<script>
// Profile dropdown functionality
function toggleProfileDropdown() {
    const dropdown = document.getElementById('profileDropdown');
    const profileBtn = document.querySelector('.profile-btn');
    const overlay = document.getElementById('dropdownOverlay');
    
    const isOpen = dropdown.classList.contains('show');
    
    // Close all dropdowns first
    closeAllDropdowns();
    
    if (!isOpen) {
        dropdown.classList.add('show');
        profileBtn.classList.add('active');
        overlay.classList.add('show');
    }
}

// Mobile menu functionality
function toggleMobileMenu() {
    const mobileNav = document.getElementById('mobileNav');
    mobileNav.classList.toggle('show');
}

// Close all dropdowns
function closeAllDropdowns() {
    const dropdown = document.getElementById('profileDropdown');
    const profileBtn = document.querySelector('.profile-btn');
    const overlay = document.getElementById('dropdownOverlay');
    
    dropdown.classList.remove('show');
    profileBtn.classList.remove('active');
    overlay.classList.remove('show');
}

// Search functionality
function filterTable() {
    const searchInput = document.getElementById('searchInput');
    const searchTerm = searchInput.value.trim();
    
    if (searchTerm) {
        // Add your search logic here
        console.log('Searching for:', searchTerm);
        // You can redirect to search results or filter existing content
        // window.location.href = '${pageContext.request.contextPath}/search?q=' + encodeURIComponent(searchTerm);
    }
}

// Close dropdown when clicking outside
document.addEventListener('click', function(event) {
    const profileDropdown = document.querySelector('.profile-dropdown');
    
    if (!profileDropdown.contains(event.target)) {
        closeAllDropdowns();
    }
});

// Close mobile menu when clicking nav items
document.querySelectorAll('.mobile-nav-item').forEach(item => {
    item.addEventListener('click', () => {
        document.getElementById('mobileNav').classList.remove('show');
    });
});

// Handle search on Enter key
document.addEventListener('DOMContentLoaded', function() {
    const searchInputs = document.querySelectorAll('.search-input');
    
    searchInputs.forEach(input => {
        input.addEventListener('keypress', function(event) {
            if (event.key === 'Enter') {
                filterTable();
            }
        });
    });
});

// Handle window resize
window.addEventListener('resize', function() {
    if (window.innerWidth > 768) {
        document.getElementById('mobileNav').classList.remove('show');
    }
});
</script>