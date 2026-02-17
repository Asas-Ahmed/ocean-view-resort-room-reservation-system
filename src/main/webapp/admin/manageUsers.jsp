<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Ocean View Resort</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
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
        <li><a href="${pageContext.request.contextPath}/system/dashboard">Dashboard Overview</a></li>
        <li><a href="${pageContext.request.contextPath}/reservation">Reservation Manager</a></li>
        
        <c:if test="${sessionScope.user.role == 'ADMIN'}">
            <li><a href="${pageContext.request.contextPath}/admin/users" class="active">Staff Directory</a></li>
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
            <h1 style="font-size: 1.8rem; color: var(--text-heading); font-weight: 800; letter-spacing: -0.5px;">Staff Management</h1>
            <p style="color: var(--text-muted); font-size: 1rem;">System-wide user access and privilege control.</p>
        </div>
        <div style="display: flex; gap: 10px;">
             <span class="badge admin-badge" style="padding: 10px 20px; border-radius: 50px;">Total Personnel: ${userList.size()}</span>
        </div>
    </header>
    
    <%-- System Notifications --%>
	<c:if test="${not empty param.msg}">
	    <div class="status-msg alert-success"> 
		    <span>✅</span> <span>${param.msg}</span>
	    </div>
	</c:if>
	
	<c:if test="${not empty error}">
	    <div class="status-msg-error">
	        ⚠️ ${error}
	    </div>
	</c:if>

    <%-- ADD/EDIT FORM CARD --%>
	<div class="form-card staff-form">
	    <h3 style="margin-bottom: 1.5rem; font-size: 1.1rem; color: var(--text-heading); font-weight: 700;">
	        ${empty editUser ? '👤 Create New Staff Member' : '✏️ Modify Account Access'}
	    </h3>
	    <form action="${pageContext.request.contextPath}/admin/users" method="post">
	        <input type="hidden" name="action" value="${empty editUser ? 'add' : 'update'}">
	        
	        <div style="display: grid; grid-template-columns: 1.2fr 1.5fr 0.8fr 0.6fr; gap: 20px; align-items: start; padding-bottom: 25px;">
	            
	            <div class="form-group" style="margin-bottom: 0;">
	                <label style="color: var(--text-muted);">Username</label>
	                <input type="text" name="newUsername" value="${editUser.username}" ${empty editUser ? '' : 'readonly'} placeholder="e.g. bob_resort" required>
	            </div>
	
	            <div class="form-group" style="margin-bottom: 0; position: relative;">
	                <label style="color: var(--text-muted);">Security Credentials</label>
	                <input type="password" name="newPassword" id="passwordInput" 
	                       placeholder="${empty editUser ? 'Enter password' : 'Keep empty for no change'}" 
	                       ${empty editUser ? 'required' : ''} oninput="checkStrength(this.value)">
	                
	                <div id="meterWrapper" style="position: absolute; width: 100%; top: 100%; left: 0;">
	                    <div id="meterContainer" style="display: none; margin-top: 5px;">
	                        <div class="strength-meter" style="height: 4px; background: #e2e8f0; border-radius: 2px;">
	                            <div id="strengthBar" style="height: 100%; width: 0%; transition: all 0.3s; border-radius: 2px;"></div>
	                        </div>
	                        <div id="strengthText" style="font-size: 0.65rem; font-weight: bold; margin-top: 2px;"></div>
	                    </div>
	                    <span class="password-hint" style="font-size: 0.65rem; color: #94a3b8; display: block;">Min 8 chars: Letters & Numbers</span>
	                </div>
	            </div>
	
	            <div class="form-group" style="margin-bottom: 0;">
	                <label style="color: var(--text-muted);">Access Permission</label>
	                <select name="newRole" style="height: 45px;">
	                    <option value="STAFF" ${editUser.role == 'STAFF' ? 'selected' : ''}>STAFF LEVEL</option>
	                    <option value="ADMIN" ${editUser.role == 'ADMIN' ? 'selected' : ''}>ADMIN LEVEL</option>
	                </select>
	            </div>
	
	            <div style="padding-top: 24px;"> <button type="submit" class="btn btn-primary" style="height: 45px; width: 100%; justify-content: center; font-size: 0.9rem;">
	                    ${empty editUser ? 'Deploy User' : 'Update Access'}
	                </button>
	            </div>
	        </div>
	
	        <c:if test="${not empty editUser}">
	            <div style="margin-top: 5px;"><a href="users" class="back-link" style="color: #ef4444; font-weight: 600;">✕ Abort Changes</a></div>
	        </c:if>
	    </form>
	</div>

    <%-- TABLE CARD --%>
    <div class="table-card">
        <div class="table-header-tool">
            <div style="display: flex; align-items: center; gap: 15px;">
			    <div style="width: 4px; height: 35px; background: var(--brand-primary); border-radius: 10px; box-shadow: 0 0 10px rgba(79, 70, 229, 0.4);"></div>
			    
			    <div>
			        <h3 style="font-size: 1.1rem; color: var(--text-heading); margin: 0;">Authorized Personnel</h3>
			        <p style="font-size: 0.8rem; color: var(--text-muted); margin: 0;">Current active system accounts</p>
			    </div>
			</div>
        </div>

        <table class="admin-table">
            <thead>
                <tr>
                    <th style="width: 40%;">User Identity</th>
                    <th style="width: 30%;">Permission Clearance</th>
                    <th style="width: 30%; text-align: right;">System Operations</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${userList}">
                    <tr>
                        <td>
                            <div style="display: flex; align-items: center; gap: 15px;">
                                <div class="user-avatar">${u.username.substring(0,1).toUpperCase()}</div>
                                <div>
                                    <div style="font-weight: 700; color: var(--text-heading); font-size: 1rem;">${u.username}</div>
                                    <div style="font-size: 0.75rem; color: var(--text-muted);">Active Member</div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <span class="badge ${u.role == 'ADMIN' ? 'admin-badge' : 'staff-badge'}" style="letter-spacing: 0.5px; padding: 6px 12px;">
                                ${u.role}
                            </span>
                        </td>
                        <td style="text-align: right;">
                            <div style="display: inline-flex; gap: 8px;">
                                <a href="users?action=edit&username=${u.username}" class="btn btn-edit">Modify</a>
								<c:if test="${sessionScope.user.username != u.username}">
								    <a href="javascript:void(0)" 
								       class="btn btn-delete" 
								       onclick="showUserDeleteModal('${u.username}', 'users?action=delete&username=${u.username}')">
								       Revoke
								    </a>
								</c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div id="deleteModal" class="modal-overlay">
    <div class="modal-card">
        <div class="modal-icon">🔐</div>
        <h3 style="color: #b91c1c;">Revoke Access</h3>
        <p>Are you sure you want to permanently delete the staff account for <span id="staffNameSpan" style="font-weight: bold; color: var(--text-heading);"></span>?</p>
        <p style="font-size: 0.8rem; color: #64748b; margin-top: 10px; background: #fff1f2; padding: 10px; border-radius: 8px;">
            ⚠️ This will immediately terminate their system login privileges.
        </p>
        <div class="modal-actions">
            <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
            <a id="confirmDeleteBtn" href="#" class="btn btn-delete" style="background: #ef4444; color: white;">Confirm Revocation</a>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/includes/theme-toggle.jsp" />
</body>
</html>