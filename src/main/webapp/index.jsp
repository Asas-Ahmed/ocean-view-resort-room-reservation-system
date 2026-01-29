<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Management Console | Ocean View</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <script src="${pageContext.request.contextPath}/resources/js/script.js" defer></script>
</head>
<body class="one-screen-layout index-page">
<div id="page-loader">
    <span class="loader-spinner"></span>
</div>

<nav class="landing-nav">
    <a href="${pageContext.request.contextPath}/index.jsp" class="logo-text">
        <span>🌊</span> OCEAN VIEW
    </a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/system/help.jsp">Support</a>
        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/auth/login.jsp" class="btn btn-primary">Sign In</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/system/dashboard" class="btn btn-primary">Dashboard</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<main class="hero-center-wrapper">
    <header class="hero-clean">
        <span class="badge-new">Reservation System v1.0</span>
        <h1>Luxury Hospitality, <br><span class="text-gradient">Driven by Data.</span></h1>
        <p>
            Unified portal for reservation tracking, guest registration, <br>
    		and on-demand billing for Ocean View Resort.
        </p>
        
        <div class="hero-actions-row">
            <a href="${pageContext.request.contextPath}/auth/login.jsp" class="btn btn-primary" style="padding: 1rem 2.5rem; font-size: 1.1rem; border-radius: 12px;">Launch System</a>
            <a href="${pageContext.request.contextPath}/system/help.jsp" class="btn btn-secondary" style="padding: 1rem 2.5rem; font-size: 1.1rem; border-radius: 12px; margin-left: 15px; background: rgba(255,255,255,0.05); color: white; border-color: rgba(255,255,255,0.1);">Documentation</a>
        </div>
    </header>
    
    <div class="quick-info-grid">
	    <div class="info-item"><strong>Secure</strong> Guest Records</div>
	    <div class="info-item"><strong>Generate</strong> Guest Bills</div>
	    <div class="info-item"><strong>Efficient</strong> Reservations</div>
	</div>
</main>

<footer class="bottom-stick">
    &copy; 2026 Ocean View Resort • Hotel Management System • Galle, Sri Lanka
</footer>

</body>
</html>