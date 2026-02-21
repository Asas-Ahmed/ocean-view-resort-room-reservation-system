package com.oceanview.controller;

import static org.mockito.Mockito.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.*;
import org.junit.jupiter.api.Test;

class LoginServletTest {
    @Test
    void testDoGet_ForwardsToLoginJsp() throws Exception {
        LoginServlet servlet = new LoginServlet();
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        RequestDispatcher dispatcher = mock(RequestDispatcher.class);

        when(request.getRequestDispatcher("/auth/login.jsp")).thenReturn(dispatcher);
        servlet.doGet(request, response);
        verify(dispatcher).forward(request, response);
    }

    @Test
    void testLogout_InvalidatesSession() throws Exception {
        LoginServlet servlet = new LoginServlet();
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        when(request.getParameter("action")).thenReturn("logout");
        when(request.getSession(false)).thenReturn(session);
        when(request.getContextPath()).thenReturn("/resort");

        servlet.doGet(request, response);
        verify(session).invalidate();
        verify(response).sendRedirect("/resort/index.jsp");
    }

    @Test
    void testFailedLogin_SetsErrorAttribute() throws Exception {
        LoginServlet servlet = new LoginServlet();
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        RequestDispatcher dispatcher = mock(RequestDispatcher.class);

        when(request.getParameter("username")).thenReturn("wrongUser");
        when(request.getParameter("password")).thenReturn("wrongPass");
        when(request.getRequestDispatcher("/auth/login.jsp")).thenReturn(dispatcher);

        servlet.doPost(request, response);
        verify(request).setAttribute(eq("error"), anyString());
    }
}