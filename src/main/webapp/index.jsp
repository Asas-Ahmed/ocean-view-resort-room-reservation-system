<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome - Ocean View Resort</title>
    <style> 
    	:root { --fey-blue: #0052cc; --fey-purple: #6c5ce7; --fey-gradient: linear-gradient(135deg, #0052cc 0%, #6c5ce7 100%); --bg-light: #f4f7fa; --text-dark: #1e293b; } 
    	body { font-family: 'Segoe UI', Arial, sans-serif; background-color: var(--bg-light); margin: 0; display: flex; justify-content: center; align-items: center; height: 100vh; color: var(--text-dark); } 
    	.hero-container { background: white; padding: 50px 40px; border-radius: 16px; box-shadow: 0 15px 35px rgba(0,0,0,0.08); text-align: center; max-width: 450px; width: 100%; border-top: 6px solid var(--fey-blue); position: relative; } 
    	h1 { color: var(--fey-blue); margin-bottom: 5px; font-size: 2rem; letter-spacing: -0.5px; } 
    	p { color: #64748b; margin-bottom: 35px; font-size: 1.1rem; font-weight: 500; } 
    	.btn-login { display: inline-block; background: var(--fey-gradient); color: white; padding: 14px 40px; text-decoration: none; border-radius: 8px; font-weight: bold; font-size: 1rem; transition: transform 0.2s, opacity 0.3s; box-shadow: 0 4px 15px rgba(108, 92, 231, 0.2); } 
    	.btn-login:hover { opacity: 0.9; transform: translateY(-2px); } 
    	.footer-note { margin-top: 30px; font-size: 0.85em; color: #94a3b8; border-top: 1px solid #f1f5f9; padding-top: 20px; } 
    </style>
</head>
<body>

    <div class="hero-container">
        <h1>🌊 Ocean View Resort</h1>
        <p>Internal Management System</p>
        
        <%-- Check if a user is already in session --%>
		<% if (session.getAttribute("user") == null) { %>
		    <a href="auth/login.jsp" class="btn-login">Go to Login</a>
		<% } else { %>
		    <a href="system/dashboard.jsp" class="btn-login">Enter Dashboard</a>
		<% } %>

        <div class="footer-note">
            © 2026 Ocean View Resort Development Team
        </div>
    </div>

</body>
</html>