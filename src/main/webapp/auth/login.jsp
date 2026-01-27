<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Ocean View Resort</title>
    <style> 
    	:root { --fey-blue: #0052cc; --fey-purple: #6c5ce7; --fey-gradient: linear-gradient(135deg, #0052cc 0%, #6c5ce7 100%); } 
    	body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: var(--fey-gradient); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; } 
    	.login-container { background: white; padding: 45px; border-radius: 16px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 400px; } 
    	h2 { text-align: center; color: var(--fey-blue); margin-bottom: 5px; font-size: 24px; } 
    	p.subtitle { text-align: center; color: #64748b; font-size: 14px; margin-bottom: 30px; text-transform: uppercase; letter-spacing: 1px; } 
    	.error-msg { color: #b91c1c; background-color: #fee2e2; border: 1px solid #fecaca; padding: 12px; border-radius: 8px; margin-bottom: 20px; text-align: center; font-size: 14px; font-weight: 600; } .form-group { margin-bottom: 22px; } 
    	label { display: block; margin-bottom: 8px; color: #1e293b; font-weight: 600; font-size: 14px; } 
    	input { width: 100%; padding: 12px 15px; border: 2px solid #e2e8f0; border-radius: 8px; box-sizing: border-box; transition: all 0.3s; font-size: 15px; } 
    	input:focus { border-color: var(--fey-purple); outline: none; box-shadow: 0 0 0 4px rgba(108, 92, 231, 0.1); } 
    	button { width: 100%; padding: 14px; background: var(--fey-gradient); border: none; color: white; border-radius: 8px; cursor: pointer; font-size: 16px; font-weight: bold; transition: transform 0.2s, opacity 0.3s; margin-top: 10px; } 
    	button:hover { opacity: 0.9; transform: translateY(-1px); } 
    	.footer-note { text-align: center; margin-top: 25px; font-size: 12px; color: #94a3b8; } 
    </style>
</head>
<body>

<div class="login-container">
    <h2>Ocean View Resort</h2>
    <p class="subtitle">Staff Management System</p>

    <%-- 
       The error message will show if the Servlet sets: 
       req.setAttribute("error", "message");
    --%>
    <c:if test="${not empty error}">
        <div class="error-msg">
            ⚠️ ${error}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="Enter username" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter password" required>
        </div>
        <button type="submit">Secure Login</button>
    </form>

    <div class="footer-note">
        &copy; 2026 Ocean View Resort Security
    </div>
</div>

</body>
</html>