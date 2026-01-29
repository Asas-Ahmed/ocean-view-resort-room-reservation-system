<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Find Reservation - Ocean View Resort</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <script src="${pageContext.request.contextPath}/resources/js/script.js" defer></script>
</head>
<body>
<div id="page-loader">
    <span class="loader-spinner"></span>
</div>

<div class="main-content">
    <div class="search-container">
        <h1>🔍 Find Reservation</h1>
        <p class="subtitle">Access billing and invoices by entering a Reservation ID</p>

        <div class="form-card search-card">
            <%-- Error Messages with better icons --%>
            <c:if test="${param.error == 'NotFound'}">
                <div class="status-msg-error">
                    <strong>Not Found!</strong> We couldn't find a record for that ID.
                </div>
            </c:if>

            <c:if test="${param.error == 'InvalidFormat'}">
                <div class="status-msg-warning">
                    <strong>Format Error!</strong> Try "105" or "RES-00105".
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/bill" method="get">
                <div class="form-group">
                    <label for="reservationId">Unique Reservation ID</label>
                    <div class="input-with-icon">
                        <input type="text" id="reservationId" name="reservationId" 
                               placeholder="e.g. RES-00105" required autocomplete="off">
                    </div>
                </div>

                <div class="search-actions">
                    <button type="submit" class="btn btn-primary">Retrieve Bill & Invoice</button>
                    <a href="${pageContext.request.contextPath}/reservation" class="btn btn-secondary">View All Registry</a>
                </div>
            </form>
        </div>

        <%-- Dynamic Search Results Table --%>
        <c:if test="${not empty searchResult}">
            <div class="search-results-area">
                <div class="table-card">
                    <div class="table-header-tool">
                        <h3>Matching Record</h3>
                    </div>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Guest Name</th>
                                <th>Room Type</th>
                                <th>Check-in</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><span class="res-id">${searchResult.formattedReservationId}</span></td>
                                <td><strong>${searchResult.guestName}</strong></td>
                                <td><span class="room-type-tag">${searchResult.roomType}</span></td>
                                <td>${searchResult.checkInDate}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/bill?reservationId=${searchResult.reservationId}" 
                                       class="btn btn-edit">📄 View Invoice</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>

        <div class="footer-nav">
            <a href="${pageContext.request.contextPath}/system/dashboard" class="back-link">← Return to Dashboard</a>
        </div>
    </div>
</div>

</body>
</html>