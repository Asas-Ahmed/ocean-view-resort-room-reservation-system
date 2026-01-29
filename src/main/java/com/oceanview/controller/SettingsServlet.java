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
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Verify it is an Admin changing the settings
        if (user != null && "ADMIN".equals(user.getRole())) {
            try {
                int newCapacity = Integer.parseInt(request.getParameter("newCapacity"));
                settingsDAO.setTotalCapacity(newCapacity);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        // Redirect back to the dashboard to see the new numbers
        response.sendRedirect(request.getContextPath() + "/system/dashboard");
    }
}