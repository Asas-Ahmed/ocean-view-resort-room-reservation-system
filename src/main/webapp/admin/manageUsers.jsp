<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Staff - Ocean View</title>
    <style> 
    :root { --fey-blue: #0052cc; --fey-purple: #6c5ce7; --fey-gradient: linear-gradient(135deg, #0052cc 0%, #6c5ce7 100%); --bg-light: #f4f7fa; --text-dark: #1e293b; } 
    body { font-family: 'Segoe UI', Arial, sans-serif; background-color: var(--bg-light); padding: 40px 20px; color: var(--text-dark); margin: 0; } 
    .container { max-width: 950px; margin: auto; background: white; padding: 35px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); } 
    h2 { color: var(--fey-blue); border-bottom: 3px solid var(--fey-purple); padding-bottom: 12px; margin-top: 0; } .form-section { background: #f8fafc; padding: 25px; border-radius: 10px; margin-bottom: 35px; border: 1px solid #e2e8f0; } 
    h3 { color: var(--text-dark); margin-top: 0; font-size: 1.1rem; } 
    .form-group { margin-bottom: 15px; } label { display: block; margin-bottom: 8px; font-weight: 600; color: var(--text-dark); font-size: 0.9rem; } 
    input, select { width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box; font-size: 14px; } 
    input:focus { outline: none; border-color: var(--fey-purple); box-shadow: 0 0 0 3px rgba(108, 92, 231, 0.1); }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; } 
    th { background: #f1f5f9; color: var(--fey-blue); padding: 15px; text-align: left; font-weight: 600; border-bottom: 2px solid #e2e8f0; } 
    td { padding: 15px; border-bottom: 1px solid #f1f5f9; }
    .btn { padding: 10px 18px; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; font-size: 14px; display: inline-block; font-weight: 600; transition: 0.3s; } 
    .btn-add, .btn-update { background: var(--fey-gradient); color: white; } 
    .btn-add:hover, .btn-update:hover { opacity: 0.9; transform: translateY(-1px); } 
    .btn-delete { background: #fee2e2; color: #dc2626; } 
    .btn-delete:hover { background: #dc2626; color: white; } 
    .btn-edit { background: #e0e7ff; color: #4338ca; margin-right: 5px; } 
    .btn-edit:hover { background: #4338ca; color: white; }
    .badge { padding: 4px 10px; border-radius: 6px; font-size: 11px; font-weight: bold; text-transform: uppercase; } 
    .admin-badge { background: #fef3c7; color: #92400e; border: 1px solid #fde68a; } 
    .staff-badge { background: #f1f5f9; color: #475569; border: 1px solid #e2e8f0; } 
    .back-link { color: var(--fey-blue); text-decoration: none; font-weight: bold; font-size: 0.95rem; } 
    .back-link:hover { text-decoration: underline; } 
    </style>
</head>
<body>

<div class="container">
    <h2>👥 Staff Account Management</h2>

    <c:if test="${not empty param.msg}">
        <p style="color: green; font-weight: bold;">✅ ${param.msg}</p>
    </c:if>

    <div class="form-section">
        <h3>${empty editUser ? '➕ Add New Staff Member' : '✏️ Edit Staff Member'}</h3>
        <form action="${pageContext.request.contextPath}/admin/users" method="post">
            <input type="hidden" name="action" value="${empty editUser ? 'add' : 'update'}">
            
            <div style="display: flex; gap: 15px;">
                <div class="form-group" style="flex: 1;">
                    <label>Username</label>
                    <input type="text" name="newUsername" value="${editUser.username}" ${empty editUser ? '' : 'readonly'} required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Password ${empty editUser ? '' : '(Leave blank to keep current)'}</label>
                    <input type="password" name="newPassword" ${empty editUser ? 'required' : ''}>
                </div>
                <div class="form-group" style="flex: 0.5;">
                    <label>Role</label>
                    <select name="newRole">
                        <option value="STAFF" ${editUser.role == 'STAFF' ? 'selected' : ''}>STAFF</option>
                        <option value="ADMIN" ${editUser.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                    </select>
                </div>
            </div>
            <button type="submit" class="btn ${empty editUser ? 'btn-add' : 'btn-update'}">
                ${empty editUser ? 'Create Account' : 'Update Account'}
            </button>
            <c:if test="${not empty editUser}">
                <a href="${pageContext.request.contextPath}/admin/users" style="margin-left: 10px; color: #666;">Cancel</a>
            </c:if>
        </form>
    </div>

    <h3>Current System Users</h3>
    <table>
        <thead>
            <tr>
                <th>Username</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${userList}">
                <tr>
                    <td><strong>${u.username}</strong></td>
                    <td>
                        <span class="badge ${u.role == 'ADMIN' ? 'admin-badge' : 'staff-badge'}">${u.role}</span>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/users?action=edit&username=${u.username}" class="btn btn-edit">✏️ Edit</a>
                        <c:if test="${sessionScope.user.username != u.username}">
                            <a href="${pageContext.request.contextPath}/admin/users?action=delete&username=${u.username}" 
                               class="btn btn-delete" onclick="return confirm('Delete user ${u.username}?')">Remove</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="${pageContext.request.contextPath}/system/dashboard.jsp" style="color: #003366; font-weight: bold; text-decoration: none;">⬅ Back to Dashboard</a>
</div>

</body>
</html>