package com.oceanview.controller;

import com.oceanview.dao.SettingsDAO;
import com.oceanview.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/system/settings")
public class SettingsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private SettingsDAO settingsDAO = new SettingsDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    try {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user != null && "ADMIN".equals(user.getRole())) {
            String capacityRaw = request.getParameter("newCapacity");
            if (capacityRaw != null) {
                int newCapacity = Integer.parseInt(capacityRaw);
                settingsDAO.setTotalCapacity(newCapacity);
            }
        }
        response.sendRedirect(request.getContextPath() + "/system/dashboard");
    } catch (Exception e) {
        throw new ServletException("Failed to update system settings", e);
    }
}
}