<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Help - Ocean View</title>
    <style> 
    	:root { --fey-blue: #0052cc; --fey-purple: #6c5ce7; --fey-gradient: linear-gradient(135deg, #0052cc 0%, #6c5ce7 100%); --bg-light: #f4f7fa; --text-dark: #1e293b; --text-muted: #475569; } 
    	body { font-family: 'Segoe UI', Arial, sans-serif; background-color: var(--bg-light); color: var(--text-dark); padding: 40px 20px; line-height: 1.6; margin: 0; } 
    	.help-container { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); max-width: 850px; margin: auto; border-top: 6px solid var(--fey-blue); } 
    	h1 { background: var(--fey-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-size: 2rem; border-bottom: 2px solid #e2e8f0; padding-bottom: 15px; margin-top: 0; } 
    	.step { margin-bottom: 30px; padding: 20px; background: #fcfcfd; border-radius: 8px; border-left: 4px solid var(--fey-purple); } 
    	.step h3 { color: var(--fey-blue); margin-top: 0; font-size: 1.2rem; }
    	table { width: 100%; border-collapse: collapse; margin: 15px 0; background: white; } 
    	th, td { border: 1px solid #e2e8f0; padding: 12px; text-align: left; } 
    	th { background-color: #f8fafc; color: var(--fey-blue); font-weight: 600; }
    	.back-link { display: inline-block; margin-top: 20px; text-decoration: none; color: var(--fey-blue); font-weight: bold; padding: 10px 20px; border: 2px solid var(--fey-blue); border-radius: 6px; transition: 0.3s; } 
    	.back-link:hover { background: var(--fey-gradient); color: white; border-color: transparent; }
    	.admin-note { background-color: #fff9db; border: 1px solid #fab005; padding: 12px; border-radius: 6px; margin-top: 15px; font-size: 0.95em; color: #856404; } 
    	code { background: #e2e8f0; padding: 2px 5px; border-radius: 4px; font-family: monospace; color: #d63384; }
    </style>
</head>
<body>
    <div class="help-container">
        <h1>📖 System User Manual</h1>
        <p>Follow these operational guidelines to manage Ocean View Resort effectively.</p>
        
        <div class="step">
            <h3>1. Reservations and Guests</h3>
            <p>Use <strong>'New Reservation'</strong> to register guests. Note the following requirements:</p>
            <ul>
                <li><strong>Contact Number:</strong> Must be exactly 10 digits.</li>
                <li><strong>Dates:</strong> Check-out must be at least one day after Check-in.</li>
            </ul>
            <c:if test="${not empty sessionScope.user and sessionScope.user.role == 'ADMIN'}">
                <div class="admin-note">
                    <strong>Admin Tip:</strong> You can <strong>Edit</strong> guest details or <strong>Delete</strong> cancelled bookings directly from the 'View Reservations' list.
                </div>
            </c:if>
        </div>

        <div class="step">
            <h3>2. Searching for Records</h3>
            <p>To find a specific booking for billing, use the <strong>'Search Guest'</strong> tool. You can enter IDs in two formats:</p>
            <ul>
                <li>Numeric format: <code>105</code></li>
                <li>System format: <code>RES-00105</code></li>
            </ul>
        </div>

        <div class="step">
            <h3>3. Room Rates and Billing</h3>
            <p>In the 'View Reservations' list, click <strong>'Invoice'</strong> to generate a printable bill.</p>
            <table>
                <tr><th>Room Type</th><th>Rate (Per Night)</th></tr>
                <tr><td>Standard / Single</td><td>$100.00</td></tr>
                <tr><td>Deluxe / Double</td><td>$150.00</td></tr>
                <tr><td>Suite</td><td>$200.00</td></tr>
            </table>
        </div>

        <div class="step">
            <h3>4. System Health Check</h3>
            <p>If the system feels slow or data isn't loading, click <strong>'System Status'</strong> on the dashboard to verify the connection between the application and the Database Server.</p>
        </div>

        <c:if test="${not empty sessionScope.user and sessionScope.user.role == 'ADMIN'}">
            <div class="step">
                <h3>5. Staff Management (Admin Only)</h3>
                <p>Access <strong>'Manage Staff'</strong> to create or remove user accounts. Current staff cannot delete their own active accounts for security reasons.</p>
            </div>
        </c:if>

        <div class="step">
            <h3>6. Security Protocol</h3>
            <p>The system session will remain active while the browser is open. Always use <strong>'Exit System'</strong> to prevent unauthorized access to guest data.</p>
        </div>

        <a href="dashboard.jsp" class="back-link">⬅ Return to Dashboard</a>
    </div>
</body>
</html>