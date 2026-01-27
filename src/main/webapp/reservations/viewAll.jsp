<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Reservations - Ocean View</title>
    <style> 
    	:root { --fey-blue: #0052cc; --fey-purple: #6c5ce7; --fey-gradient: linear-gradient(135deg, #0052cc 0%, #6c5ce7 100%); --bg-light: #f4f7fa; --text-dark: #1e293b; } 
    	body { font-family: 'Segoe UI', Arial, sans-serif; background-color: var(--bg-light); padding: 40px 20px; color: var(--text-dark); margin: 0; } 
    	.container { background: white; padding: 35px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); max-width: 1000px; margin: auto; border-top: 6px solid var(--fey-blue); } h2 { color: var(--fey-blue); margin-top: 0; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; } 
    	.status-msg { background-color: #dcfce7; color: #166534; padding: 12px; border-radius: 8px; border: 1px solid #bbf7d0; margin-bottom: 20px; font-size: 0.95rem; } 
    	table { width: 100%; border-collapse: separate; border-spacing: 0; margin-top: 10px; } 
    	th { background-color: #f8fafc; color: var(--fey-blue); padding: 15px; text-align: left; font-weight: 600; border-bottom: 2px solid #e2e8f0; text-transform: uppercase; font-size: 0.85rem; letter-spacing: 0.5px; } 
    	td { padding: 15px; border-bottom: 1px solid #f1f5f9; vertical-align: middle; color: #475569; } 
    	tr:hover td { background-color: #fcfcfd; } 
    	tr:last-child td { border-bottom: none; } 
    	.btn { text-decoration: none; padding: 8px 14px; border-radius: 6px; font-size: 13px; display: inline-block; font-weight: 600; transition: all 0.2s ease; } 
    	.btn-bill { background: #eff6ff; color: #2563eb; border: 1px solid #dbeafe; } 
    	.btn-bill:hover { background: var(--fey-gradient); color: white; border-color: transparent; } 
    	.btn-edit { background: #fef9c3; color: #854d0e; border: 1px solid #fef08a; } 
    	.btn-edit:hover { background: #facc15; color: #422006; } 
    	.btn-delete { background: #fee2e2; color: #dc2626; border: 1px solid #fecaca; } 
    	.btn-delete:hover { background: #dc2626; color: white; } 
    	a[style*="font-weight: bold"] { display: inline-block; margin-top: 25px; color: var(--fey-blue) !important; transition: 0.2s; } 
    	a[style*="font-weight: bold"]:hover { text-decoration: underline; opacity: 0.8; } 
    </style>
</head>
<body>

<div class="container">
    <h2>📋 Guest Reservation Registry</h2>

    <%-- Success/Error Messages --%>
    <c:if test="${not empty param.msg}">
        <p class="status-msg">✅ ${param.msg}</p>
    </c:if>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Guest Name</th>
                <th>Room Type</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="res" items="${reservations}">
                <tr>
                    <td><strong><c:out value="${res.formattedReservationId}"/></strong></td>
                    
                    <td><c:out value="${res.guestName}"/></td>
                    
                    <td><c:out value="${res.roomType}"/></td>
                    
                    <td>
                        <a href="${pageContext.request.contextPath}/bill?reservationId=${res.reservationId}" class="btn btn-bill">📄 Invoice</a>
                        
                        <%-- Admin Only Actions --%>
                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/reservation?action=edit&id=${res.reservationId}" class="btn btn-edit">✏️ Edit</a>
                            <a href="${pageContext.request.contextPath}/reservation?action=delete&id=${res.reservationId}" 
                               class="btn btn-delete" 
                               onclick="return confirm('Permanently delete this reservation for ${res.guestName}?')">🗑️ Delete</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="${pageContext.request.contextPath}/system/dashboard.jsp" style="text-decoration: none; color: #003366; font-weight: bold;">⬅ Back to Dashboard</a>
</div>

</body>
</html>