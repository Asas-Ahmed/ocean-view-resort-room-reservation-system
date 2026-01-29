<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Reservations - Ocean View Resort</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <script src="${pageContext.request.contextPath}/resources/js/script.js" defer></script>
</head>
<body class="dashboard-body">
<div id="page-loader">
    <span class="loader-spinner"></span>
</div>

<div class="sidebar">
    <div class="sidebar-brand">
        <h2 style="margin-bottom: 0;">🌊 OCEAN VIEW</h2>
        <p style="font-size: 0.65rem; color: var(--text-muted); letter-spacing: 1px;">RESORT MANAGEMENT</p>
    </div>
    
    <ul>
        <li><a href="${pageContext.request.contextPath}/system/dashboard">Dashboard Overview</a></li>
        <li><a href="${pageContext.request.contextPath}/reservation" class="active">Reservation Manager</a></li>
        
        <c:if test="${sessionScope.user.role == 'ADMIN'}">
            <li><a href="${pageContext.request.contextPath}/admin/users">Staff Directory</a></li>
        </c:if>
        
        <li><a href="${pageContext.request.contextPath}/system/help.jsp">Support Center</a></li>
    </ul>
    
    <div style="margin-top: auto; padding: 1rem; background: rgba(255,255,255,0.05); border-radius: 12px;">
        <p style="font-size: 0.7rem; color: #94a3b8; text-transform: uppercase; margin-bottom: 0.8rem;">Current Staff</p>
        <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 1rem;">
            <div class="user-avatar">${sessionScope.user.username.substring(0,1).toUpperCase()}</div>
            <div style="overflow: hidden;">
                <p style="font-weight: 600; font-size: 0.85rem; color: white; white-space: nowrap; text-overflow: ellipsis;">${sessionScope.user.username}</p>
                <p style="font-size: 0.75rem; color: #94a3b8;">${sessionScope.user.role}</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-secondary" style="width: 100%; font-size: 0.75rem; justify-content: center; padding: 8px;">Log Out</a>
    </div>
</div>

<div class="main-content">
    <header style="margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: flex-end;">
        <div>
            <h1 style="font-size: 1.8rem; color: var(--text-heading);">Guest Registry</h1>
            <p style="color: var(--text-muted)">Viewing all current and upcoming reservations.</p>
        </div>
        <a href="${pageContext.request.contextPath}/reservations/add.jsp" class="btn btn-primary">
            <span>+</span> New Reservation
        </a>
    </header>

    <c:if test="${not empty param.msg}">
        <div class="alert-success">
            ✅ ${param.msg}
        </div>
    </c:if>

    <div class="table-card">
        <table class="table">
            <thead>
                <tr>
                    <th>Ref ID</th>
                    <th>Guest Name</th>
                    <th>Room Type</th>
                    <th>Check-in</th>
                    <th>Check-out</th>
                    <th style="text-align: right;">Operations</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="res" items="${reservations}">
                    <tr>
                        <td class="res-id"><c:out value="${res.formattedReservationId}"/></td>
                        <td style="font-weight: 600; color: var(--text-heading);"><c:out value="${res.guestName}"/></td>
                        <td><span class="room-type-tag"><c:out value="${res.roomType}"/></span></td>
                        <td><c:out value="${res.checkInDate}"/></td>
                        <td><c:out value="${res.checkOutDate}"/></td>
                        <td>
                            <div class="action-cell" style="justify-content: flex-end;">
                                <a href="${pageContext.request.contextPath}/bill?reservationId=${res.reservationId}" class="btn btn-invoice">
                                    📄 Invoice
                                </a>

                                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/reservation?action=edit&id=${res.reservationId}" class="btn btn-edit">Edit</a>
                                    <a href="javascript:void(0)" class="btn btn-delete" onclick="showDeleteModal('${res.guestName}', '${pageContext.request.contextPath}/reservation?action=delete&id=${res.reservationId}')"> 
                                    	Delete 
                                    </a>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty reservations}">
                    <tr>
                        <td colspan="6" style="text-align:center; padding: 3rem; color: var(--text-muted);">
                            <div style="font-size: 2rem; margin-bottom: 10px;">📋</div>
                            No guest records found.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<div id="deleteModal" class="modal-overlay">
    <div class="modal-card">
        <div class="modal-icon">⚠️</div>
        <h3>Confirm Deletion</h3>
        <p>Are you sure you want to remove the reservation for <span id="guestNameSpan" style="font-weight: bold;"></span>?</p>
        <p style="font-size: 0.8rem; color: #64748b; margin-top: 5px;">This action cannot be undone.</p>
        <div class="modal-actions">
            <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
            <a id="confirmDeleteBtn" href="#" class="btn btn-delete">Delete Record</a>
        </div>
    </div>
</div>

</body>
</html>