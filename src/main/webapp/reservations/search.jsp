<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Reservation - Ocean View</title>
    <style> 
    	:root { --fey-blue: #0052cc; --fey-purple: #6c5ce7; --fey-gradient: linear-gradient(135deg, #0052cc 0%, #6c5ce7 100%); --bg-light: #f4f7fa; --text-dark: #1e293b; } 
    	body { font-family: 'Segoe UI', Arial, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background-color: var(--bg-light); color: var(--text-dark); } 
    	.search-box { background: white; padding: 40px; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); width: 420px; text-align: center; border-top: 6px solid var(--fey-blue); } .error-alert { background-color: #fee2e2; color: #b91c1c; padding: 15px; border-radius: 8px; margin-bottom: 25px; border: 1px solid #fecaca; font-size: 0.9em; line-height: 1.5; } h2 { color: var(--fey-blue); margin-top: 0; font-size: 1.8rem; } 
    	p { margin-bottom: 5px; font-weight: 500; } 
    	input { width: 100%; padding: 14px; margin: 15px 0; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 1em; outline: none; transition: all 0.3s ease; box-sizing: border-box; } 
    	input:focus { border-color: var(--fey-purple); box-shadow: 0 0 0 4px rgba(108, 92, 231, 0.1); } 
    	button { width: 100%; padding: 14px; background: var(--fey-gradient); color: white; border: none; border-radius: 8px; cursor: pointer; font-size: 1em; font-weight: bold; transition: transform 0.2s, opacity 0.3s; } 
    	button:hover { opacity: 0.9; transform: translateY(-1px); } 
    	.hint { font-size: 0.85em; color: #64748b; font-style: italic; margin-bottom: 10px; } 
    	.back-link { margin-top: 25px; display: inline-block; text-decoration: none; color: var(--fey-blue); font-size: 0.95em; font-weight: 600; } 
    	.back-link:hover { text-decoration: underline; } 
    </style>
</head>
<body>

    <div class="search-box">
        <h2>🔍 Find Reservation</h2>

        <%-- ERROR SECTION: Only displays if redirect sends back ?error=... --%>
        <c:if test="${param.error == 'NotFound'}">
            <div class="error-alert">
                ❌ <strong>Reservation Not Found!</strong><br>
                Please check the ID and try again.
            </div>
        </c:if>

        <c:if test="${param.error == 'InvalidFormat'}">
            <div class="error-alert">
                ⚠️ <strong>Invalid Format!</strong><br>
                Please enter a valid numeric or RES-ID.
            </div>
        </c:if>

        <p>Enter the Unique Reservation ID:</p>
        <p class="hint">Format: 105 or RES-00105</p>
        
        <form action="../bill" method="get">
            <input type="text" name="reservationId" placeholder="e.g. RES-00002" required autocomplete="off">
            <br>
            <button type="submit">Retrieve Bill Details</button>
        </form>
        
        <a href="../system/dashboard.jsp" class="back-link">⬅ Back to Dashboard</a>
    </div>

</body>
</html>