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
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            if (!isAdmin(req)) {
                resp.sendRedirect(req.getContextPath() + "/auth/login.jsp");
                return;
            }

            String action = req.getParameter("action");
            String username = req.getParameter("username");

            if ("edit".equals(action) && username != null) {
                User u = userDAO.getUserByUsername(username);
                req.setAttribute("editUser", u);
            } 
            else if ("delete".equals(action) && username != null) {
                userDAO.deleteUser(username);
                resp.sendRedirect("users?msg=User+Removed");
                return;
            }

            List<User> userList = userDAO.getAllUsers();
            req.setAttribute("userList", userList);
            req.getRequestDispatcher("/admin/manageUsers.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("Admin User Operation Failed", e);
        }
    }

    @Override 
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { 
        try {
            if (!isAdmin(req)) { 
                resp.sendError(HttpServletResponse.SC_FORBIDDEN); 
                return; 
            } 
            
            String action = req.getParameter("action"); 
            String u = req.getParameter("newUsername"); 
            String p = req.getParameter("newPassword"); 
            String r = req.getParameter("newRole"); 

            if ("update".equals(action)) { 
                userDAO.updateUser(u, p, r); 
                resp.sendRedirect("users?msg=User+Updated"); 
            } else { 
                userDAO.addUser(new User(u, p, r)); 
                resp.sendRedirect("users?msg=User+Added"); 
            } 
        } catch (Exception e) {
            throw new ServletException("Error modifying user data", e);
        }
    }

    private boolean isAdmin(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            return user != null && "ADMIN".equals(user.getRole());
        }
        return false;
    }
}