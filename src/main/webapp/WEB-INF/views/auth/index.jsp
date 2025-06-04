<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Arize - Advanced Trading Platform</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #ffffff;
            min-height: 100vh;
            color: #333;
        }

        .header {
            background: #ffffff;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid #e5e7eb;
        }

        .nav-container {
            display: flex;
            justify-content: center;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo {
            width: 50px;
            height: 50px;
            background: linear-gradient(45deg, #1f2937, #374151);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: bold;
            box-shadow: 0 4px 15px rgba(31, 41, 55, 0.2);
        }

        .logo-text {
            font-size: 32px;
            font-weight: 700;
            color: #1f2937;
            letter-spacing: -0.5px;
        }

        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 6rem 2rem;
            text-align: center;
        }

        .hero-section {
            margin-bottom: 6rem;
        }

        .hero-title {
            font-size: 4rem;
            font-weight: 800;
            color: #1f2937;
            margin-bottom: 2rem;
            line-height: 1.1;
            letter-spacing: -2px;
        }

        .hero-subtitle {
            font-size: 1.4rem;
            color: #6b7280;
            margin-bottom: 3rem;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
            font-weight: 400;
        }

        .cta-container {
            margin-bottom: 6rem;
        }

        .btn-primary {
            background: linear-gradient(45deg, #1f2937, #374151);
            color: white;
            padding: 20px 40px;
            font-size: 18px;
            font-weight: 600;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(31, 41, 55, 0.2);
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(31, 41, 55, 0.3);
            background: linear-gradient(45deg, #374151, #4b5563);
        }

        .features-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 3rem;
            margin-bottom: 6rem;
        }

        .feature-card {
            background: #ffffff;
            padding: 3rem 2rem;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
            border: 1px solid #f3f4f6;
            transition: all 0.3s ease;
            text-align: left;
        }

        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }

        .feature-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(45deg, #1f2937, #374151);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            color: white;
            font-size: 28px;
        }

        .feature-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 1rem;
            letter-spacing: -0.5px;
        }

        .feature-description {
            color: #6b7280;
            line-height: 1.7;
            font-size: 1rem;
        }

        .stats-section {
            background: #f9fafb;
            padding: 4rem 0;
            margin: 6rem 0;
            border-radius: 24px;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 3rem;
            max-width: 800px;
            margin: 0 auto;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 800;
            color: #1f2937;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            font-size: 1rem;
            color: #6b7280;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.8rem;
            }
            
            .hero-subtitle {
                font-size: 1.2rem;
            }
            
            .main-content {
                padding: 4rem 1rem;
            }
            
            .features-section {
                grid-template-columns: 1fr;
                gap: 2rem;
            }
            
            .feature-card {
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="nav-container">
            <div class="logo-section">
                <div class="logo">A</div>
                <div class="logo-text">Arize</div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <section class="hero-section">
            <h1 class="hero-title">Professional Trading Platform</h1>
            <p class="hero-subtitle">
                Experience institutional-grade trading with advanced analytics, real-time market data, 
                and sophisticated trading tools designed for serious traders and investment professionals.
            </p>
            <div class="cta-container">
            <form action="/arise/login" >
                <button class="btn-primary">Start Trading</button>
            </form>
            </div>
        </section>

        <section class="stats-section">
            <div class="stats-container">
                <div class="stat-item">
                    <div class="stat-number">$2.4B</div>
                    <div class="stat-label">Daily Volume</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">150K+</div>
                    <div class="stat-label">Active Traders</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">99.9%</div>
                    <div class="stat-label">Uptime</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">24/7</div>
                    <div class="stat-label">Support</div>
                </div>
            </div>
        </section>

        <section class="features-section">
            <div class="feature-card">
                <div class="feature-icon">ð</div>
                <h3 class="feature-title">Advanced Analytics</h3>
                <p class="feature-description">
                    Professional-grade charting tools with technical indicators, algorithmic trading signals, 
                    and comprehensive market analysis to support sophisticated trading strategies.
                </p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">ð</div>
                <h3 class="feature-title">Institutional Security</h3>
                <p class="feature-description">
                    Bank-level security infrastructure with multi-layer encryption, cold storage solutions, 
                    and compliance with international financial regulations and standards.
                </p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">â¡</div>
                <h3 class="feature-title">Ultra-Low Latency</h3>
                <p class="feature-description">
                    Sub-millisecond order execution with direct market access, co-location services, 
                    and optimized trading infrastructure for maximum performance.
                </p>
            </div>
        </section>
    </main>
</body>
</html>