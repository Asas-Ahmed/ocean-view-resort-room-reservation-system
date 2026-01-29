<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Reservation - Ocean View Resort</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <script src="${pageContext.request.contextPath}/resources/js/script.js" defer></script>
</head>
<body class="dashboard-body">
<div id="page-loader">
    <span class="loader-spinner"></span>
</div>

<div class="main-content">
    <div class="form-card" style="max-width: 700px; margin: 2rem auto;">
        <h1>✏️ Edit Reservation <span class="res-id">#${res.reservationId}</span></h1>

        <c:if test="${not empty error}">
            <p class="error-msg">⚠️ ${error}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/reservation" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="reservationId" value="${res.reservationId}">

            <div class="form-group">
                <label>Reservation ID</label>
                <input type="text" value="RES-${res.reservationId}" readonly>
            </div>

            <div class="form-group">
                <label for="guestName">Guest Name</label>
                <input type="text" id="guestName" name="guestName" value="${res.guestName}" placeholder="Full Name" required>
            </div>

            <div class="form-group">
                <label for="address">Address</label>
                <textarea id="address" name="address" rows="3" required>${res.address}</textarea>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="contactNumber">Contact Number</label>
                    <input type="tel" id="contactNumber" name="contactNumber" value="${res.contactNumber}" placeholder="10-digit mobile" required>
                </div>
                <div class="form-group">
                    <label for="roomType">Room Type</label>
                    <select id="roomType" name="roomType" required>
                        <option value="Standard" ${res.roomType == 'Standard' ? 'selected' : ''}>Standard</option>
                        <option value="Deluxe" ${res.roomType == 'Deluxe' ? 'selected' : ''}>Deluxe</option>
                        <option value="Suite" ${res.roomType == 'Suite' ? 'selected' : ''}>Suite</option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="checkIn">Check-in Date</label>
                    <input type="date" id="checkIn" name="checkInDate" value="${res.checkInDate}" required>
                </div>
                <div class="form-group">
                    <label for="checkOut">Check-out Date</label>
                    <input type="date" id="checkOut" name="checkOutDate" value="${res.checkOutDate}" required>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-bottom: 12px;">Save Changes</button>
                <a href="${pageContext.request.contextPath}/reservation" class="btn btn-secondary" style="width: 100%; justify-content: center;">Discard Edits</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>