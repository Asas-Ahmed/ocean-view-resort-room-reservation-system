package com.oceanview.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {
	    "/system/*", 
	    "/admin/*", 
	    "/dashboard", 
	    "/reservations/*", 
	    "/billing/*", 
	    "/reservation",
	    "/bill",
	    "/settings"
})
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
    	

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        String requestURI = request.getRequestURI();
        
        // URIs that anyone (even guests) should be able to see
        String loginURI = request.getContextPath() + "/auth/login.jsp";
        String loginServlet = request.getContextPath() + "/login";
        String helpURI = request.getContextPath() + "/system/help.jsp";
        String resourcePath = request.getContextPath() + "/resources/";
        String errorPath = request.getContextPath() + "/errors/";

        // Check if user is logged in
        boolean loggedIn = (session != null && session.getAttribute("user") != null);
        
        // Check if the request is for a "Public" page
        boolean isLoginRequest = requestURI.equals(loginURI) || requestURI.equals(loginServlet);
        boolean isHelpRequest = requestURI.equals(helpURI);
        boolean isResourceRequest = requestURI.startsWith(resourcePath);
        boolean isSettingsRequest = requestURI.equals(request.getContextPath() + "/system/settings");
        boolean isErrorRequest = requestURI.startsWith(errorPath);

        if (loggedIn) {
            com.oceanview.model.User user = (com.oceanview.model.User) session.getAttribute("user");

            // Check if a non-admin is trying to access the /admin/ folder
            if (requestURI.contains("/admin/") && !"admin".equalsIgnoreCase(user.getRole())) {
                response.sendError(403); // This shows 403.jsp
                return; 
            }
            
            // If they are admin, or just visiting regular pages, let them through
            chain.doFilter(req, res);

        } else if (isLoginRequest || isHelpRequest || isResourceRequest || isSettingsRequest || isErrorRequest) {
            // If not logged in, but visiting a "Public" page, let them through
            chain.doFilter(req, res);
        } else {
            // Not logged in and trying to see private stuff? Go to login.
            response.sendRedirect(loginURI);
        }
    }

    public void init(FilterConfig filterConfig) throws ServletException {}
    public void destroy() {}
}