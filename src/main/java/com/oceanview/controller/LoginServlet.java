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

        try {
            User user = userDAO.getUserByUsername(username);

            if (user != null && org.mindrot.jbcrypt.BCrypt.checkpw(password, user.getPassword())) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                resp.sendRedirect(req.getContextPath() + "/system/dashboard");
                return; 
            }
            
            req.setAttribute("error", "Invalid username or password.");
            req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);

        } catch (Exception e) {
            // Triggers 500.jsp automatically if DB password is wrong
            throw new ServletException("Login Database Error", e);
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
        
        try {
            req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
        } catch (ServletException e) {
            e.printStackTrace(); // Log the error
        }
    }
}