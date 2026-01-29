<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Help Center | Ocean View Resort</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <script src="${pageContext.request.contextPath}/resources/js/script.js" defer></script>
    <style>
        /* Guest View Adjustments */
        <c:if test="${empty sessionScope.user}">
        .dashboard-body { display: block; } 
        .main-content { margin-left: 0; padding: 4rem 10%; max-width: 1200px; margin: 0 auto; }
        .help-grid { grid-template-columns: 1fr; }
        @media (min-width: 1024px) {
            .help-grid { grid-template-columns: 280px 1fr; gap: 3rem; }
        }
        </c:if>
        
        .help-section-card code {
            background: #f1f5f9;
            padding: 2px 6px;
            border-radius: 4px;
            font-family: 'Courier New', Courier, monospace;
            color: #e11d48;
        }
    </style>
</head>
<body class="dashboard-body">
<div id="page-loader">
    <span class="loader-spinner"></span>
</div>

<%-- SIDEBAR: Only rendered if user is logged in --%>
<c:if test="${not empty sessionScope.user}">
    <div class="sidebar">
        <div class="sidebar-brand">
            <h2 style="margin-bottom: 0;">🌊 OCEAN VIEW</h2>
            <p style="font-size: 0.65rem; color: var(--text-muted); letter-spacing: 1px;">RESORT MANAGEMENT</p>
        </div>
        
        <ul>
            <li><a href="${pageContext.request.contextPath}/system/dashboard">Dashboard Overview</a></li>
            <li><a href="${pageContext.request.contextPath}/reservation">Reservation Manager</a></li>
            
            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                <li><a href="${pageContext.request.contextPath}/admin/users">Staff Directory</a></li>
            </c:if>
            
            <li><a href="${pageContext.request.contextPath}/system/help.jsp" class="active">Support Center</a></li>
        </ul>
        
        <div style="margin-top: auto; padding: 1rem; background: rgba(255,255,255,0.05); border-radius: 12px;">
            <p style="font-size: 0.7rem; color: #94a3b8; text-transform: uppercase; margin-bottom: 0.8rem;">Current Staff</p>
            <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 1rem;">
                <div class="user-avatar">
                    <c:out value="${not empty sessionScope.user.username ? sessionScope.user.username.substring(0,1).toUpperCase() : '?'}" />
                </div>
                <div style="overflow: hidden;">
                    <p style="font-weight: 600; font-size: 0.85rem; color: white; white-space: nowrap; text-overflow: ellipsis;">${sessionScope.user.username}</p>
                    <p style="font-size: 0.75rem; color: #94a3b8;">${sessionScope.user.role}</p>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="btn btn-secondary" style="width: 100%; font-size: 0.75rem; justify-content: center; padding: 8px;">Exit System (Log Out)</a>
        </div>
    </div>
</c:if>

<div class="main-content">
    <%-- GUEST TOP NAVIGATION --%>
    <c:if test="${empty sessionScope.user}">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 3rem; border-bottom: 1px solid var(--border-soft); padding-bottom: 1.5rem;">
            <a href="${pageContext.request.contextPath}/index.jsp" class="logo-text" style="text-decoration: none; font-size: 1.5rem; color: var(--bg-sidebar); font-weight: 800;">
                <span>🌊</span> OCEAN VIEW
            </a>
            <a href="${pageContext.request.contextPath}/auth/login.jsp" class="btn btn-primary">Staff Sign In</a>
        </div>
    </c:if>

    <header style="margin-bottom: 3rem;">
        <h1 style="font-size: 2.5rem; color: var(--text-heading); font-weight: 800; letter-spacing: -1px;">Knowledge Base</h1>
        <p style="color: var(--text-muted); font-size: 1.1rem;">Operational guidelines and system documentation.</p>
    </header>

    <div class="help-grid">
        <nav class="help-nav">
            <h4>Documentation</h4>
            <ul>
                <li><a href="#reservations">Guest Registration</a></li>
                <li><a href="#search">Finding Records</a></li>
                <li><a href="#billing">Rates & Billing</a></li>
                <li><a href="#config">System Configuration</a></li>
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <li><a href="#admin">Administration</a></li>
                </c:if>
                <li><a href="#security">Security Protocol</a></li>
            </ul>
            <div style="margin-top: 2rem;">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/system/dashboard" class="btn btn-secondary" style="width:100%; font-size:0.8rem; justify-content: center;">Back to Dashboard</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary" style="width:100%; font-size:0.8rem; justify-content: center;">Back to Home</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>

        <div class="help-articles">
			<section id="reservations" class="help-section-card">
			    <h2><i>01</i> Guest Registration</h2>
			    <p>Register new guests by collecting the mandatory details required by the Ocean View management system.</p>
			    <div class="info-box">
			        <strong>Mandatory Fields & Validation:</strong>
			        <ul style="margin-top: 8px; margin-left: 15px;">
			            <li><b>Required Details:</b> Reservation Number, Guest Name, Address, Contact Number, Room Type, and Dates (Check-in/Out).</li>
			            <li><b>Contact Validation:</b> Contact numbers must be exactly 10 digits.</li>
			            <li><b>Stay Policy:</b> Stay duration must be at least 24 hours (1 night).</li>
			        </ul>
			    </div>
			</section>

            <section id="search" class="help-section-card">
                <h2><i>02</i> Search & Retrieval</h2>
                <p>The global search bar supports flexible input formats for identifying guest folios.</p>
                <table class="admin-table" style="margin-top: 1rem;">
                    <thead>
                        <tr><th>Type</th><th>Format Example</th></tr>
                    </thead>
                    <tbody>
                        <tr><td>Short ID</td><td><code>105</code></td></tr>
                        <tr><td>Full Reference</td><td><code>RES-00105</code></td></tr>
                    </tbody>
                </table>
            </section>

			<section id="billing" class="help-section-card">
			    <h2><i>03</i> Rates & Billing</h2>
			    <p>The system calculates the total stay cost based on nightly rates and the duration of stay.</p>
			    
			    <table class="admin-table" style="margin-top: 1rem; margin-bottom: 1rem;">
			        <thead>
			            <tr><th>Room Category</th><th>Nightly Rate</th></tr>
			        </thead>
			        <tbody>
			            <tr><td>Standard</td><td>Rs. 18,000.00</td></tr>
			            <tr><td>Deluxe</td><td>Rs. 35,000.00</td></tr>
			            <tr><td>Suite</td><td>Rs. 55,000.00</td></tr>
			        </tbody>
			    </table>
			
			    <div class="info-box">
			        <strong>Billing Functionality:</strong>
			        <p style="font-size: 0.9rem;">
			            To <b>Calculate and Print Bill</b>, open the reservation record. The system will multiply the 
			            Nightly Rate by the number of nights. Use the 'Print' button to generate the guest invoice.
			        </p>
			    </div>
			</section>

            <section id="config" class="help-section-card">
                <h2><i>04</i> System Configuration</h2>
                <p>Administrative control over the resort's physical limitations and real-time availability settings.</p>
                <div class="info-box">
                    <strong>Capacity Management:</strong>
                    <p style="font-size: 0.9rem; margin-top: 5px;">
                        Adjusting the <b>Total Capacity</b> updates the Dashboard metrics instantly. 
                        Calculation: <code>Available Rooms = Total Capacity - Active Bookings</code>.
                    </p>
                </div>
            </section>

            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                <section id="admin" class="help-section-card" style="border-left-color: #f59e0b;">
                    <h2 style="color: #b45309;"><i>05</i> Administration & Governance</h2>
                    <p>Elevated access allows for personnel management and critical system overrides.</p>
                    <div class="admin-note" style="background: #fffbeb; border: 1px solid #fef3c7; padding: 1rem; color: #92400e; border-radius: 8px;">
                        <strong>Revocation Protocol:</strong> To prevent accidental data loss, removing staff or reservations requires an <b>Administrative Confirmation Modal</b> override.
                    </div>
                </section>
            </c:if>

            <section id="security" class="help-section-card">
                <h2><i>06</i> Security Protocol</h2>
                <p>Standard data protection protocols for guest privacy and system integrity:</p>
                <ul style="margin-left: 20px; color: var(--text-body); line-height: 1.8;">
                    <li><b>Session Security:</b> Terminate sessions when leaving the terminal.</li>
                    <li><b>Verification:</b> Verify Guest Identity before providing invoice copies or modifying check-out dates.</li>
                </ul>
            </section>
        </div>
    </div>
</div>

</body>
</html>