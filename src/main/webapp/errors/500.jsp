<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>System Error | Ocean View</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body class="is-loading">
    <div id="page-loader"><span class="loader-spinner"></span></div>

    <div class="error-page-wrapper">
        <div class="error-glass-card">
            <h1 class="error-code-hero" style="background: linear-gradient(135deg, #ef4444 0%, #991b1b 100%); -webkit-background-clip: text;">500</h1>
            <h2 class="error-title">System Collision</h2>
            <p class="error-desc">Our server hit an unexpected wave. The developers have been alerted. Try refreshing or come back in a few minutes.</p>
            <div class="error-actions">
                <button onclick="window.history.back()" class="btn btn-primary">
                    ⬅️ Go to Previous Page
                </button>
                <button onclick="location.reload()" class="btn btn-secondary">Try Again</button>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
</body>
</html>