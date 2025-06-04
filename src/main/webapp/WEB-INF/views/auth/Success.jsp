<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Success!</title>
  <style>
    :root {
      --success-primary: #28a745;
      --success-secondary: #218838;
      --success-light: #d4edda;
      --success-dark: #155724;
      --background: #f8f9fa;
      --card-bg: #ffffff;
      --text-primary: #212529;
      --text-secondary: #6c757d;
      --shadow-light: rgba(0, 0, 0, 0.08);
      --shadow-medium: rgba(0, 0, 0, 0.12);
      --shadow-strong: rgba(0, 0, 0, 0.16);
      --border-radius: 16px;
      --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
      padding: 20px;
      line-height: 1.6;
    }

    .success-wrapper {
      width: 100%;
      max-width: 520px;
      margin: 0 auto;
    }

    .success-container {
      background: var(--card-bg);
      background: linear-gradient(145deg, #ffffff, #f8f9fa);
      border-left: 8px solid var(--success-primary);
      padding: 3rem 2.5rem;
      border-radius: var(--border-radius);
      box-shadow: 
        0 10px 40px var(--shadow-light),
        0 4px 12px var(--shadow-medium),
        inset 0 1px 0 rgba(255, 255, 255, 0.8);
      text-align: center;
      position: relative;
      overflow: hidden;
      transition: var(--transition);
    }

    .success-container::before {
      content: '';
      position: absolute;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: radial-gradient(circle, rgba(40, 167, 69, 0.05) 0%, transparent 70%);
      pointer-events: none;
    }

    .success-container:hover {
      transform: translateY(-4px);
      box-shadow: 
        0 15px 50px var(--shadow-medium),
        0 8px 20px var(--shadow-strong),
        inset 0 1px 0 rgba(255, 255, 255, 0.9);
    }

    .success-icon {
      width: 80px;
      height: 80px;
      background: linear-gradient(135deg, var(--success-primary), var(--success-secondary));
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 1.5rem;
      position: relative;
      box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3);
      animation: pulse 2s infinite;
    }

    .success-icon::after {
      content: '✓';
      color: white;
      font-size: 2.5rem;
      font-weight: bold;
      animation: checkmark 0.6s ease-in-out 0.3s both;
    }

    @keyframes pulse {
      0%, 100% {
        transform: scale(1);
        box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3);
      }
      50% {
        transform: scale(1.05);
        box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
      }
    }

    @keyframes checkmark {
      0% {
        transform: scale(0) rotate(45deg);
        opacity: 0;
      }
      50% {
        transform: scale(1.2) rotate(45deg);
        opacity: 1;
      }
      100% {
        transform: scale(1) rotate(45deg);
        opacity: 1;
      }
    }

    .success-container h1 {
      color: var(--success-primary);
      font-size: 2.5rem;
      font-weight: 700;
      margin-bottom: 1rem;
      letter-spacing: -0.025em;
      position: relative;
      z-index: 1;
    }

    .success-container p {
      color: var(--text-primary);
      font-size: 1.125rem;
      margin-bottom: 2.5rem;
      opacity: 0.8;
      position: relative;
      z-index: 1;
    }

    .btn-home {
      background: linear-gradient(135deg, var(--success-primary), var(--success-secondary));
      color: white;
      text-decoration: none;
      padding: 1rem 2.5rem;
      border-radius: 12px;
      font-weight: 600;
      font-size: 1.1rem;
      display: inline-block;
      transition: var(--transition);
      text-transform: uppercase;
      letter-spacing: 0.5px;
      box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
      position: relative;
      z-index: 1;
      overflow: hidden;
    }

    .btn-home::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
      transition: left 0.5s;
    }

    .btn-home:hover {
      background: linear-gradient(135deg, var(--success-secondary), #1e7e34);
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
    }

    .btn-home:hover::before {
      left: 100%;
    }

    .btn-home:active {
      transform: translateY(0);
      box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
    }

    /* Decorative elements */
    .decoration {
      position: absolute;
      width: 100px;
      height: 100px;
      border-radius: 50%;
      background: linear-gradient(45deg, rgba(40, 167, 69, 0.1), rgba(40, 167, 69, 0.05));
      animation: float 6s ease-in-out infinite;
    }

    .decoration:nth-child(1) {
      top: -50px;
      right: -50px;
      animation-delay: -2s;
    }

    .decoration:nth-child(2) {
      bottom: -50px;
      left: -50px;
      animation-delay: -4s;
    }

    @keyframes float {
      0%, 100% {
        transform: translateY(0px) rotate(0deg);
      }
      50% {
        transform: translateY(-20px) rotate(180deg);
      }
    }

    /* Responsive Design */
    @media (max-width: 768px) {
      body {
        padding: 15px;
      }
      
      .success-container {
        padding: 2.5rem 2rem;
      }
      
      .success-container h1 {
        font-size: 2.2rem;
      }
      
      .success-container p {
        font-size: 1rem;
      }
      
      .btn-home {
        padding: 0.9rem 2rem;
        font-size: 1rem;
      }
      
      .success-icon {
        width: 70px;
        height: 70px;
      }
      
      .success-icon::after {
        font-size: 2rem;
      }
    }

    @media (max-width: 480px) {
      .success-container {
        padding: 2rem 1.5rem;
        margin: 10px;
      }
      
      .success-container h1 {
        font-size: 1.9rem;
      }
      
      .success-container p {
        font-size: 0.95rem;
        margin-bottom: 2rem;
      }
      
      .btn-home {
        width: 100%;
        padding: 1rem;
        font-size: 0.95rem;
      }
      
      .success-icon {
        width: 60px;
        height: 60px;
        margin-bottom: 1rem;
      }
      
      .success-icon::after {
        font-size: 1.8rem;
      }
    }

    @media (max-width: 320px) {
      .success-container {
        padding: 1.5rem 1rem;
      }
      
      .success-container h1 {
        font-size: 1.6rem;
      }
      
      .btn-home {
        padding: 0.8rem;
        font-size: 0.9rem;
      }
    }

    /* High contrast mode */
    @media (prefers-contrast: high) {
      .success-container {
        border: 2px solid var(--success-primary);
      }
      
      .btn-home {
        border: 2px solid var(--success-secondary);
      }
    }

    /* Reduced motion */
    @media (prefers-reduced-motion: reduce) {
      * {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
      }
      
      .success-icon {
        animation: none;
      }
      
      .decoration {
        animation: none;
      }
    }

    /* Print styles */
    @media print {
      body {
        background: white;
      }
      
      .success-container {
        box-shadow: none;
        border: 2px solid var(--success-primary);
      }
      
      .btn-home {
        background: var(--success-primary) !important;
        color: white !important;
      }
    }
  </style>
</head>
<body>
  <div class="decoration"></div>
  <div class="decoration"></div>
  
  <div class="success-wrapper">
    <div class="success-container">
      <div class="success-icon"></div>
      <h1>${message}</h1>
      <p>Your registration was completed successfully.</p>
      <a href="${pageContext.request.contextPath}/arise/login" class="btn-home">Go to Login</a>
    </div>
  </div>
</body>
</html>