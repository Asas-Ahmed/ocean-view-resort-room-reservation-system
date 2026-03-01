<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="com.oceanview.model.User" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>

<%
    // SECURITY: Redirect if not logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Ocean View Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<script>
	    window.ResortConfig = {
	        contextPath: '${pageContext.request.contextPath}'
	    };
	</script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
	    (function() {
	        const savedTheme = localStorage.getItem('theme');
	        if (savedTheme === 'dark') {
	            document.documentElement.setAttribute('data-theme', 'dark');
	        }
	    })();
	</script>
	<script>
	    (function() {
	        const savedTheme = localStorage.getItem('theme');
	        if (savedTheme === 'dark') {
	            document.documentElement.setAttribute('data-theme', 'dark');
	        }
	    })();
	</script>
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
        <li><a href="${pageContext.request.contextPath}/system/dashboard" class="active">Dashboard Overview</a></li>
        <li><a href="${pageContext.request.contextPath}/reservation">Reservation Manager</a></li>
        
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
    <header style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 3rem;">
        <div>
            <h1 style="font-size: 2.2rem; font-weight: 800; color: var(--text-heading); letter-spacing: -0.5px;">Dashboard</h1>
            <p style="color: var(--text-muted);">Welcome back. Here is what's happening today.</p>
        </div>
        <div style="text-align: right;">
            <%-- Restricted to ADMIN only --%>
		    <c:if test="${sessionScope.user.role == 'ADMIN'}">
		        <div id="db-status-indicator" class="indicator">
		            <span>Database Checking...</span>
		        </div>
		    </c:if>
            <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: 8px; font-weight: 500;">
                <%= LocalDateTime.now().format(DateTimeFormatter.ofPattern("EEEE, MMM dd")) %>
            </p>
        </div>
    </header>
    
    <div style="background: white; padding: 1.5rem; border-radius: 12px; margin-bottom: 2rem; border: 1px solid var(--border-soft);">
	    <h4 style="margin-bottom: 1rem; color: var(--text-heading);">Export Reports</h4>
	    <form action="${pageContext.request.contextPath}/system/export" method="GET" style="display: flex; gap: 15px; align-items: flex-end;">
	        <div>
	            <label style="font-size: 0.75rem; display: block; margin-bottom: 5px;">Start Date</label>
	            <input type="date" name="startDate" class="input-modern" required>
	        </div>
	        <div>
	            <label style="font-size: 0.75rem; display: block; margin-bottom: 5px;">End Date</label>
	            <input type="date" name="endDate" class="input-modern" required>
	        </div>
	        <div>
	            <label style="font-size: 0.75rem; display: block; margin-bottom: 5px;">Format</label>
	            <select name="format" class="input-modern">
	                <option value="pdf">Professional PDF</option>
	                <option value="csv">Excel / CSV</option>
	            </select>
	        </div>
	        <button type="submit" class="btn btn-primary">Download Report</button>
	    </form>
	</div>

	<div class="stats-container">
	    <div class="stat-card">
	        <h3>Active Bookings</h3>
	        <span class="value">
	            <c:out value="${totalRes}" default="0"/>
	        </span>
	        <div class="stat-icon">📅</div>
	    </div>
	
	    <div class="stat-card">
	        <h3>Expected Arrivals</h3>
	        <span class="value">
	            <c:out value="${arrivalsToday}" default="0"/>
	        </span>
	        <div class="stat-icon">🛎️</div>
	    </div>
	
	    <div class="stat-card">
	        <h3>Available Rooms</h3>
	        <span class="value">
	            <c:out value="${availableRooms}" default="50"/>
	        </span>
	        <div class="stat-icon">🏠</div>
	    </div>
	</div>
	
	<h3 style="font-size: 1rem; color: var(--text-heading); margin: 2.5rem 0 1.5rem; display: flex; align-items: center; gap: 10px;">
        Management Shortcuts <span style="flex-grow: 1; height: 1px; background: var(--border-soft);"></span>
    </h3>

    <div class="action-grid" style="padding-bottom:50px;">
        <a href="${pageContext.request.contextPath}/reservations/add.jsp" class="action-tile">
            <div class="icon-box">➕</div>
            <div>
                <h4>New Guest Intake</h4>
                <p>Register a new stay and assign room keys.</p>
            </div>
        </a>
        
        <a href="${pageContext.request.contextPath}/reservations/search.jsp" class="action-tile">
            <div class="icon-box">🔍</div>
            <div>
                <h4>Search & Billing</h4>
                <p>Find guest records and generate invoices.</p>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/reservation" class="action-tile">
            <div class="icon-box">📋</div>
            <div>
                <h4>Reservation Log</h4>
                <p>Access the full database of resort stays.</p>
            </div>
        </a>
    </div>
    
    <%-- Admin Only: Capacity Settings --%>
	<c:if test="${sessionScope.user.role == 'ADMIN'}">
	    <div style="background: white; padding: 1.5rem; border-radius: 12px; margin-bottom: 2rem; border: 1px solid var(--border-soft); display: flex; align-items: center; justify-content: space-between;">
	        <div>
	            <h4 style="margin: 0; color: var(--text-heading);">Resort Capacity</h4>
	            <p style="margin: 0; font-size: 0.8rem; color: var(--text-muted);">Adjust the total number of rooms available in the resort.</p>
	        </div>
	        <form action="${pageContext.request.contextPath}/system/settings" method="POST" style="display: flex; gap: 10px;">
				<input type="number" 
				       name="newCapacity" 
				       class="input-modern capacity-input"
				       value="${totalCapacity}" 
				       min="1" 
				       required>
	            <button type="submit" class="btn btn-primary" style="padding: 8px 15px; font-size: 0.8rem;">Update</button>
	        </form>
	    </div>
	</c:if>
	
	<h3 style="font-size: 1rem; color: var(--text-heading); margin: 2.5rem 0 1.5rem; display: flex; align-items: center; gap: 10px;">
	    Executive Overview <span style="flex-grow: 1; height: 1px; background: var(--border-soft);"></span>
	</h3>
	
	<div style="display: grid; grid-template-columns: 1fr 2fr; gap: 20px; margin-bottom: 2rem;">
	    <div class="stat-card-v2" style="display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 2rem;">
	        <h4 style="margin-bottom: 1.5rem; color: var(--text-muted); font-size: 0.9rem;">Live Occupancy</h4>
	        <div style="position: relative; width: 100%; max-width: 200px;">
	            <canvas id="occupancyChart"></canvas>
	            <div class="chart-overlay">
	                <span class="percentage">${Math.round((totalRes / totalCapacity) * 100)}%</span>
	                <span class="label">Full</span>
	            </div>
	        </div>
	    </div>
	
	    <div class="stat-card-v2">
	        <h4 style="margin-bottom: 1rem; color: var(--text-muted); font-size: 0.9rem;">Inventory by Room Type</h4>
	        <canvas id="roomTypeChart" style="max-height: 250px;"></canvas>
	    </div>
	</div>
	
	<%-- Restricted to ADMIN only --%>
    <c:if test="${sessionScope.user.role == 'ADMIN'}">
		<div style="background: white; padding: 1.5rem; border-radius: 12px; border: 1px solid var(--border-soft); margin-bottom: 2rem;">
		    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
		        <div>
		            <h4 style="margin:0;">Revenue Projection (Next 7 Days)</h4>
		            <p style="font-size: 0.8rem; color: var(--text-muted);">Projected income based on confirmed check-ins.</p>
		        </div>
		        <div style="text-align: right;">
		            <span style="font-size: 1.5rem; font-weight: 800; color: #10b981;">Rs. ${revenue}</span>
		            <p style="font-size: 0.7rem; color: #10b981; margin:0;">Total Expected Intake</p>
		        </div>
		    </div>
		    <canvas id="revenueTrendChart" style="max-height: 300px;"></canvas>
		</div>
	</c:if>
</div>

<jsp:include page="/WEB-INF/includes/theme-toggle.jsp" />
<script>
document.addEventListener("DOMContentLoaded", function() {
    // Helper to get CSS variables for JS
    const getStyle = (varName) => getComputedStyle(document.documentElement).getPropertyValue(varName).trim();

    const isDark = document.documentElement.getAttribute('data-theme') === 'dark';
    const primary = '#4f46e5';
    const secondary = '#0ea5e9';
    const textHeading = getStyle('--text-heading');
    const textMuted = getStyle('--text-muted');
    const borderSoft = isDark ? '#27272a' : '#e2e8f0';

    // Occupancy Doughnut
    new Chart(document.getElementById('occupancyChart'), {
        type: 'doughnut',
        data: {
            labels: ['Occupied', 'Available'],
            datasets: [{
                data: [${totalRes}, ${availableRooms}],
                backgroundColor: [primary, isDark ? '#27272a' : '#f1f5f9'],
                borderWidth: 0,
                hoverOffset: 4
            }]
        },
        options: { 
            cutout: '75%', 
            plugins: { legend: { display: false } },
            animation: { animateRotate: true }
        }
    });

    // Room Type Bar Chart
    new Chart(document.getElementById('roomTypeChart'), {
        type: 'bar',
        data: {
            labels: ['Standard', 'Deluxe', 'Suite'],
            datasets: [{
                data: [${stdCount}, ${dlxCount}, ${steCount}],
                backgroundColor: [secondary, primary, '#4338ca'],
                borderRadius: 8,
                barThickness: 30
            }]
        },
        options: { 
            indexAxis: 'y', 
            plugins: { legend: { display: false } },
            scales: { 
                x: { 
                    grid: { display: false },
                    ticks: { color: textMuted }
                }, 
                y: { 
                    grid: { display: false },
                    ticks: { color: textMuted }
                } 
            }
        }
    });

    // Revenue Trend
    const revCtx = document.getElementById('revenueTrendChart').getContext('2d');
    const revGradient = revCtx.createLinearGradient(0, 0, 0, 300);
    revGradient.addColorStop(0, isDark ? 'rgba(79, 70, 229, 0.4)' : 'rgba(79, 70, 229, 0.1)');
    revGradient.addColorStop(1, 'rgba(79, 70, 229, 0)');

    new Chart(revCtx, {
        type: 'line',
        data: {
            labels: ['Today', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'],
            datasets: [{
                label: 'Revenue (Rs.)',
                data: ${revenueData},
                borderColor: primary,
                backgroundColor: revGradient,
                fill: true,
                tension: 0.4,
                pointRadius: 4,
                pointBackgroundColor: primary,
                pointBorderColor: isDark ? '#1e1e22' : '#fff',
                pointBorderWidth: 2
            }]
        },
        options: {
            plugins: { legend: { display: false } },
            scales: {
                y: { 
                    grid: { color: borderSoft },
                    ticks: { color: textMuted, callback: v => 'Rs.' + v } 
                },
                x: { 
                    grid: { display: false },
                    ticks: { color: textMuted } 
                }
            }
        }
    });
});
</script>
</body>
</html>