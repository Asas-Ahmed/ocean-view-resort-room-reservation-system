<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied | Ocean View</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body class="is-loading">
    <div id="page-loader"><span class="loader-spinner"></span></div>
    
    <div class="error-page-wrapper">
        <div class="error-glass-card">
            <h1 class="error-code-hero" style="background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); -webkit-background-clip: text;">403</h1>
            <h2 class="error-title">Area Restricted</h2>
            <p class="error-desc">You've reached a secure area. Your current staff role does not have permission to access these admin controls.</p>
            <div class="error-actions">
                <button onclick="window.history.back()" class="btn btn-primary">
                    ⬅️ Go to Previous Page
                </button>
                <a href="${pageContext.request.contextPath}" class="btn btn-secondary">Home</a>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
</body>
</html>