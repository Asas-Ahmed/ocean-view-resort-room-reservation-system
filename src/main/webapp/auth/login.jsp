<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Ocean View Resort</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <script src="${pageContext.request.contextPath}/resources/js/script.js" defer></script>
</head>
<body class="login-page-body">
<div id="page-loader">
    <span class="loader-spinner"></span>
</div>

<div class="login-split-container">
    <div class="login-visual">
        <div class="brand">🌊 Ocean View</div>
        <div>
            <div class="quote">Seamless operations <br>starts with a secure <br><span class="text-gradient">entry point.</span></div>
            <p style="margin-top: 20px; color: #94a3b8; font-size: 0.9rem;">Reservation Management System v1.0</p>
        </div>
        <div style="font-size: 0.8rem; opacity: 0.6;">© 2026 Ocean View Resort • Galle</div>
    </div>

    <div class="login-form-area">
        <h2>Welcome back</h2>
        <p class="login-form-caption">Enter your staff credentials to access the System.</p>

        <c:if test="${not empty error}">
            <div class="status-msg-error">
                <strong>Access Denied:</strong> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">Staff Username</label>
                <input type="text" id="username" name="username" placeholder="jsmith_admin" required autofocus>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="••••••••" required>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center; margin-top: 1rem;">
                Login to System
            </button>
        </form>
        
        <div style="margin-top: 2.5rem; text-align: center;">
            <a href="${pageContext.request.contextPath}/index.jsp" style="color: var(--text-muted); text-decoration: none; font-size: 0.85rem; font-weight: 500;">
                ← Back to Homepage
            </a>
        </div>
    </div>
</div>

</body>
</html>