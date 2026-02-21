package com.oceanview.controller;

import static org.mockito.Mockito.*;
import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.lang.reflect.Field;
import java.util.ArrayList;

class AdminUserServletTest {

    private AdminUserServlet servlet;
    private UserDAO mockUserDAO;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private RequestDispatcher dispatcher;

    @BeforeEach
    void setUp() throws Exception {
        servlet = new AdminUserServlet();
        mockUserDAO = mock(UserDAO.class);
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        session = mock(HttpSession.class);
        dispatcher = mock(RequestDispatcher.class);

        // Inject the mock DAO
        Field field = AdminUserServlet.class.getDeclaredField("userDAO");
        field.setAccessible(true);
        field.set(servlet, mockUserDAO);

        // Setup the "Admin" Security Bypass
        when(request.getSession(false)).thenReturn(session);
        User adminUser = new User("admin", "pass", "ADMIN");
        when(session.getAttribute("user")).thenReturn(adminUser);
    }

    @Test
    void testListUsers_SuccessfulForward() throws Exception {
        when(request.getRequestDispatcher("/admin/manageUsers.jsp")).thenReturn(dispatcher);
        when(mockUserDAO.getAllUsers()).thenReturn(new ArrayList<>());

        servlet.doGet(request, response);
        
        // Check that userList was actually set
        verify(request).setAttribute(eq("userList"), any());
        verify(dispatcher).forward(request, response);
    }

    @Test
    void testDeleteUserAction() throws Exception {
        when(request.getParameter("action")).thenReturn("delete");
        when(request.getParameter("username")).thenReturn("teststaff");

        servlet.doGet(request, response);
        
        verify(mockUserDAO).deleteUser("teststaff");
        verify(response).sendRedirect(contains("msg=User+Removed"));
    }

    @Test
    void testAddUserPost() throws Exception {
        when(request.getParameter("action")).thenReturn("add");
        when(request.getParameter("newUsername")).thenReturn("newuser");
        when(request.getParameter("newPassword")).thenReturn("password123");
        when(request.getParameter("newRole")).thenReturn("STAFF");

        servlet.doPost(request, response);
        
        verify(mockUserDAO).addUser(any(User.class));
        verify(response).sendRedirect(contains("msg=User+Added"));
    }
}