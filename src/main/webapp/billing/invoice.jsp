<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Invoice - ${reservation.guestName}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <script src="${pageContext.request.contextPath}/resources/js/script.js" defer></script>
    <style>
        /* For a clean printout */
        @media print {
            .no-print { display: none !important; }
            body { background: white; padding: 0; }
            .invoice-card { box-shadow: none; border: 1px solid #eee; }
        }
    </style>
</head>
<body>
<div id="page-loader">
    <span class="loader-spinner"></span>
</div>

<div class="main-content">
    <div class="invoice-card">
        <div class="invoice-header">
		    <div>
		        <h1>🌊 Ocean View Resort</h1>
		        <p style="text-align: left;">Guest Billing Statement</p>
		    </div>
		    <div style="text-align: right;"> <p>123 Beachside Avenue, Galle, Sri Lanka</p>
		        <p>Phone: +94 91 123 4567</p>
		        <p>info@oceanviewresort.lk</p>
		    </div>
		</div>

        <hr>

        <div class="invoice-details">
            <p><strong>Invoice Number:</strong> <c:out value="${reservation.formattedReservationId}"/></p>
            <p><strong>Guest Name:</strong> <c:out value="${reservation.guestName}"/></p>
            <p><strong>Contact:</strong> <c:out value="${reservation.contactNumber}"/></p>
            <p><strong>Check-in Date:</strong> <fmt:formatDate value="${reservation.checkInDate}" pattern="yyyy-MM-dd"/></p>
            <p><strong>Check-out Date:</strong> <fmt:formatDate value="${reservation.checkOutDate}" pattern="yyyy-MM-dd"/></p>
        </div>

        <table class="invoice-table">
		    <thead>
		        <tr>
		            <th>Description</th>
		            <th>Room Type</th>
		            <th>Total Stay Cost</th>
		        </tr>
		    </thead>
		    <tbody>
		        <tr>
		            <td>Accommodation</td>
		            <td><c:out value="${reservation.roomType}"/></td>
		            <td>
		                <strong style="color: var(--brand-primary);">
		                    Rs. <fmt:formatNumber value="${totalBill}" minFractionDigits="2" maxFractionDigits="2"/>
		                </strong>
		            </td>
		        </tr>
		    </tbody>
		</table>
		
		<div class="invoice-total">
		    <h3>Amount Due: Rs. <fmt:formatNumber value="${totalBill}" minFractionDigits="2" maxFractionDigits="2"/></h3>
		    <p style="font-size: 0.8rem; color: #666;">* Inclusive of all service charges and taxes.</p>
		</div>

        <div class="invoice-actions no-print" style="margin-top: 30px; text-align: center;">
            <button class="btn btn-primary" onclick="window.print()">🖨️ Print Invoice</button>
            <button class="btn btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/system/dashboard'">Dashboard</button>
            <a href="${pageContext.request.contextPath}/reservation" class="btn btn-link">Back to Registry</a>
        </div>
    </div>
</div>

</body>
</html>