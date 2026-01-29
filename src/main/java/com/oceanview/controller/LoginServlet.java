package com.oceanview.controller;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        /* // ONE-TIME RUN BLOCK (Disabled now that DB is populated)
    	if (userDAO.getUserByUsername("admin") == null) {
            userDAO.addUser(new User("admin", "admin123", "ADMIN"));
        }
        if (userDAO.getUserByUsername("staff1") == null) {
            userDAO.addUser(new User("staff1", "password123", "STAFF"));
        }
        */

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Fetch user from DB
        User user = userDAO.getUserByUsername(username);

        try {
            // Verify user exists and BCrypt hash matches the raw password
            if (user != null && org.mindrot.jbcrypt.BCrypt.checkpw(password, user.getPassword())) {
                
                // Create Session
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                
                // Success Redirect
                resp.sendRedirect(req.getContextPath() + "/system/dashboard");
                return; 
            }
            
            // Login failed logic
            req.setAttribute("error", "Invalid username or password.");
            req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);

        } catch (Exception e) {
            // Log error for developers but show clean message to user
            req.setAttribute("error", "An internal security error occurred.");
            req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        
        if ("logout".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate(); // Destroys the session completely
            }
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }
        
        resp.sendRedirect(req.getContextPath() + "/auth/login.jsp");
    }
}