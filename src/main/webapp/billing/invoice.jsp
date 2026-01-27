<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Final Invoice - Ocean View</title>
    <style> 
    	@media print { .no-print { display: none !important; } 
    	body { background-color: white !important; margin: 0; } 
    	.invoice-box { border: none !important; box-shadow: none !important; } } :root { --fey-blue: #0052cc; --fey-purple: #6c5ce7; --fey-gradient: linear-gradient(135deg, #0052cc 0%, #6c5ce7 100%); --text-dark: #1e293b; } 
    	body { font-family: 'Segoe UI', Arial, sans-serif; margin: 40px 20px; background-color: #f1f5f9; color: var(--text-dark); } 
    	.invoice-box { background: white; border: 1px solid #e2e8f0; padding: 50px; max-width: 750px; margin: auto; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); position: relative; overflow: hidden; }
    	.invoice-box::before { content: ""; position: absolute; top: 0; left: 0; right: 0; height: 6px; background: var(--fey-gradient); } 
    	.header { border-bottom: 2px solid #f1f5f9; padding-bottom: 20px; margin-bottom: 30px; } 
    	.header 
    	h1 { color: var(--fey-blue); margin: 0; font-size: 24px; } 
    	.header p { color: #64748b; margin: 5px 0 0 0; font-size: 0.9rem; text-transform: uppercase; letter-spacing: 1px; } 
    	.details h3 { color: var(--fey-purple); font-size: 1.1rem; margin-bottom: 20px; } 
    	.details p { margin: 12px 0; font-size: 1rem; display: flex; justify-content: space-between; border-bottom: 1px dashed #f1f5f9; padding-bottom: 8px; } 
    	.details p strong { color: #475569; } 
    	.total-section { background-color: #f8fafc; padding: 25px; border-radius: 8px; margin-top: 35px; text-align: right; border: 1px solid #e2e8f0; } 
    	.total { font-size: 1.8em; color: var(--fey-blue); } 
    	.no-print { margin-top: 40px; text-align: center; } 
    	.btn { padding: 12px 25px; text-decoration: none; border-radius: 8px; font-weight: bold; cursor: pointer; display: inline-block; transition: 0.3s; } 
    	.btn-print { background: var(--fey-gradient); color: white; border: none; box-shadow: 0 4px 12px rgba(108, 92, 231, 0.2); } 
    	.btn-print:hover { transform: translateY(-2px); opacity: 0.9; } 
    	.nav-links { margin-top: 20px; color: #94a3b8; font-size: 0.95em; } 
    	.nav-links a { color: var(--fey-blue); text-decoration: none; font-weight: 600; margin: 0 10px; } 
    	.nav-links a:hover { text-decoration: underline; } 
    </style>
</head>
<body>

<div class="invoice-box">
    <div class="header">
        <h1>🌊 Ocean View Resort</h1>
        <p>Galle, Sri Lanka | Official Guest Invoice</p>
    </div>

    <div class="details">
        <h3>Reservation Details</h3>
        <p><strong>Reservation Number:</strong> <c:out value="${reservation.formattedReservationId}"/></p>
        <p><strong>Guest Name:</strong> <c:out value="${reservation.guestName}"/></p>
        <p><strong>Address:</strong> <c:out value="${reservation.address}"/></p>
        <p><strong>Contact:</strong> <c:out value="${reservation.contactNumber}"/></p>
        <p><strong>Room Type:</strong> <c:out value="${reservation.roomType}"/></p>
        <p><strong>Period of Stay:</strong> 
            <fmt:formatDate value="${reservation.checkInDate}" pattern="MMM dd, yyyy"/> to 
            <fmt:formatDate value="${reservation.checkOutDate}" pattern="MMM dd, yyyy"/>
        </p>
    </div>

    <div class="total-section">
        <div class="total">
            <strong>Total Amount Due: 
                <fmt:formatNumber value="${totalBill}" type="currency" currencySymbol="$"/>
            </strong>
        </div>
        <p style="margin-top:5px; font-size:0.9em; color:#666;">* All taxes and resort fees included.</p>
    </div>

    <div class="no-print">
        <button onclick="window.print()" class="btn btn-print">🖨️ Print Invoice</button>
        <br><br>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/reservation">📋 Registry</a> | 
            <a href="${pageContext.request.contextPath}/system/dashboard.jsp">🏠 Dashboard</a> |
            <a href="${pageContext.request.contextPath}/login?action=logout" style="color:red;">🚪 Exit</a>
        </div>
    </div>
</div>

</body>
</html>