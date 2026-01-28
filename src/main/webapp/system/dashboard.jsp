<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.User" %>
<%
    // Security Check
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Ocean View Resort</title>
	<style> 
		:root { --fey-blue: #0052cc; --fey-purple: #6c5ce7; --fey-gradient: linear-gradient(135deg, #0052cc 0%, #6c5ce7 100%); --bg-light: #f4f7fa; --text-dark: #1a202c; --text-muted: #4a5568; } 
		body { font-family: 'Segoe UI', Arial, sans-serif; background-color: var(--bg-light); color: var(--text-dark); margin: 0; line-height: 1.6; }
		.navbar { background: var(--fey-gradient); color: white; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); } 
		.navbar h2 { color: white; margin: 0; } 
		.container { padding: 2rem; max-width: 1100px; margin: 0 auto; } 
		.welcome-card, .card { background: white; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); } 
		.welcome-card { padding: 30px; border-left: 6px solid var(--fey-purple); margin-bottom: 2rem; }
		h1 { color: var(--fey-blue); margin-bottom: 10px; } p { color: var(--text-muted); } .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; } 
		.card { padding: 25px; border: 1px solid #e2e8f0; transition: all 0.3s ease; text-align: center; } 
		.card:hover { transform: translateY(-5px); border-color: var(--fey-purple); box-shadow: 0 8px 15px rgba(108, 92, 231, 0.1); }
		.card h3 { color: var(--fey-blue); margin-top: 0; font-size: 1.3rem; } 
		.btn-logout { color: white; text-decoration: none; border: 1px solid rgba(255,255,255,0.5); padding: 6px 15px; border-radius: 5px; } 
		.btn-logout:hover { background: white; color: var(--fey-blue); }
		table { width: 100%; border-collapse: collapse; margin-top: 20px; background: white; } 
		th { background: #edf2f7; color: var(--fey-blue); padding: 12px; border: 1px solid #e2e8f0; } td { padding: 12px; border: 1px solid #e2e8f0; text-align: left; } 
	</style>
</head>
<body>

<div class="navbar">
    <h2>🌊 Ocean View Resort</h2>
    <div>
        <span>Logged in as: <strong><%= user.getUsername() %></strong> (<%= user.getRole() %>)</span>
        <a href="../login?action=logout" class="btn-logout" style="margin-left: 20px;">Logout</a>
    </div>
</div>

<div class="container">
    <div class="welcome-card">
        <h1>Management Dashboard</h1>
        <p>Select an action below to manage resort operations.</p>
    </div>

    <div class="grid">
	    <div class="card" onclick="location.href='../reservations/add.jsp';" style="cursor: pointer;">
	        <h3>➕ New Reservation</h3>
	        <p>Register new guests and assign unique reservation numbers for upcoming stays.</p>
	    </div>
	
	    <div class="card" onclick="location.href='../reservation';" style="cursor: pointer;">
	        <h3>📋 View Reservations</h3>
	        <p>Access the complete registry of all guests, room assignments, and check-in schedules.</p>
	    </div>
	    
	    <div class="card" onclick="location.href='../reservations/search.jsp';" style="cursor: pointer;">
	        <h3>🔍 Search Guest</h3>
	        <p>Quickly retrieve detailed booking information using a unique Reservation ID.</p>
	    </div>
	    
	    <c:if test="${not empty sessionScope.user and sessionScope.user.role == 'ADMIN'}">
		    <div class="card" onclick="location.href='../dbtest';" style="cursor: pointer;">
		        <h3>⚙️ System Status</h3>
		        <p>Monitor real-time database connectivity and core server performance.</p>
		    </div>
	    </c:if>
	    
	    <c:if test="${not empty sessionScope.user and sessionScope.user.role == 'ADMIN'}">
		    <div class="card" onclick="location.href='../admin/users';" style="border-color: #ffd700; cursor: pointer;">
		        <h3>👥 Manage Staff</h3>
		        <p>Add, remove, or change passwords for resort staff.</p>
		    </div>
		</c:if>
		
		<div class="card" onclick="location.href='help.jsp';" style="cursor: pointer;">
	        <h3>📖 Help Section</h3>
	        <p>View operational guidelines and room rates for the Ocean View management system.</p>
	    </div>
		
		<div class="card" onclick="location.href='../login?action=logout';" style="cursor: pointer; border-color: #ff4d4d;">
	        <h3>🚪 Exit System</h3>
	        <p>Securely log out of the management console and protect guest privacy.</p>
	    </div>
	</div>
</div>

</body>
</html>