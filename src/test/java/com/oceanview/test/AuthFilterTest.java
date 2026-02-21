package com.oceanview.test;

import static org.mockito.Mockito.*;
import com.oceanview.filter.AuthFilter;
import com.oceanview.model.User;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.*;
import org.junit.jupiter.api.Test;

class AuthFilterTest {

    @Test
    void testUnauthenticatedUser_RedirectsToLogin() throws Exception {
        AuthFilter filter = new AuthFilter();
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        FilterChain chain = mock(FilterChain.class);

        when(request.getRequestURI()).thenReturn("/resort/system/dashboard");
        when(request.getSession(false)).thenReturn(null);
        when(request.getContextPath()).thenReturn("/resort");

        filter.doFilter(request, response, chain);
        verify(response).sendRedirect("/resort/auth/login.jsp");
    }

    @Test
    void testAuthenticatedUser_ContinuesChain() throws Exception {
        AuthFilter filter = new AuthFilter();
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        FilterChain chain = mock(FilterChain.class);
        HttpSession session = mock(HttpSession.class);
        User mockUser = new User();
        mockUser.setUsername("testuser");
        when(request.getRequestURI()).thenReturn("/resort/system/dashboard");
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("user")).thenReturn(mockUser); // Return the real User
        filter.doFilter(request, response, chain);
        verify(chain).doFilter(request, response);
    }

    @Test
    void testStaticResources_AreBypassed() throws Exception {
        AuthFilter filter = new AuthFilter();
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        FilterChain chain = mock(FilterChain.class);
        when(request.getRequestURI()).thenReturn("/resort/resources/css/style.css");
        when(request.getContextPath()).thenReturn("/resort");
        
        filter.doFilter(request, response, chain);
        
        verify(chain, atLeastOnce()).doFilter(request, response);
    }
}