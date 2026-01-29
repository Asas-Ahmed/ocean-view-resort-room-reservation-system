<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lost at Sea | Ocean View</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body class="is-loading">
    <div id="page-loader"><span class="loader-spinner"></span></div>

    <div class="error-page-wrapper">
        <div class="error-glass-card">
            <h1 class="error-code-hero">404</h1>
            <h2 class="error-title">Page Not Found</h2>
            <p class="error-desc">The island you're looking for has drifted away. It might have been moved or the URL might be mistyped.</p>
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