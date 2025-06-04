<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<style>
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

#ticker {
    top: 0;
    left: 0;
    right: 0;
    width: 100%;
    background-color: #111;
    color: #fff;
    padding: 12px 0;
    white-space: nowrap;
    overflow: hidden;
    position: relative;
    font-family: Arial, sans-serif;
    border-bottom: 1px solid #333;
    margin-bottom: 40px;
}

.ticker-content {
    display: inline-block;
    animation: tickerScroll var(--ticker-animation-speed) linear infinite;
    animation-delay: 0s;
    animation-fill-mode: none;
    will-change: transform;
}

.stock-item {
    margin: 0 50px;
    display: inline-block;
    font-size: 16px;
    color: #fff;
}

.stock-symbol {
    font-weight: bold;
    color: #ffffff;
    margin-right: 15px;
}

.stock-high {
    color: #4CAF50;
    margin: 0 15px;
}

.stock-low {
    color: #f44336;
    margin: 0 15px;
}

.icon {
    font-size: 14px;
    margin-right: 5px;
}

/* Animation Control - Only Speed Control */
:root {
    --ticker-animation-speed: 60s;    /* Change this to control speed only */
}

@keyframes tickerScroll {
    0% {
        transform: translateX(100%);
    }
    100% {
        transform: translateX(-100%);
    }
}

/* Pause animation on hover */
#ticker:hover .ticker-content {
    animation-play-state: paused;
}
</style>

<div class="main-wrapper">
    <div id="ticker">
        <div class="ticker-content">
            <c:forEach items="${stocks}" var="stock">
                <span class="stock-item">
                    <span class="stock-symbol">${stock.symbol}</span>
                    <span class="stock-high">
                        <span class="icon">▲</span>H: ${stock.high}
                    </span>
                    <span class="stock-low">
                        <span class="icon">▼</span>L: ${stock.low}
                    </span>
                </span>
            </c:forEach>
            <!-- Triple content for seamless infinite loop -->
            <c:forEach items="${stocks}" var="stock">
                <span class="stock-item">
                    <span class="stock-symbol">${stock.symbol}</span>
                    <span class="stock-high">
                        <span class="icon">▲</span>H: ${stock.high}
                    </span>
                    <span class="stock-low">
                        <span class="icon">▼</span>L: ${stock.low}
                    </span>
                </span>
            </c:forEach>
            <!-- Third copy for perfect infinite loop -->
            <c:forEach items="${stocks}" var="stock">
                <span class="stock-item">
                    <span class="stock-symbol">${stock.symbol}</span>
                    <span class="stock-high">
                        <span class="icon">▲</span>H: ${stock.high}
                    </span>
                    <span class="stock-low">
                        <span class="icon">▼</span>L: ${stock.low}
                    </span>
                </span>
            </c:forEach>
        </div>
    </div>

    <!-- Chart Container (Ensure it has class) -->
    <div class="chart-container">
        <canvas id="stockChart"></canvas>
    </div>
</div>