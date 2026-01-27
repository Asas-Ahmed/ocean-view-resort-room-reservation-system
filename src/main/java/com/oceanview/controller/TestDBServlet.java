package com.oceanview.controller;

import com.oceanview.util.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/dbtest")
public class TestDBServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	    resp.setContentType("text/html");
	    
	    // Header for consistent styling
	    resp.getWriter().println("<html><head><style>");
	    resp.getWriter().println(":root { --fey-blue: #0052cc; --fey-purple: #6c5ce7; --bg-light: #f4f7fa; }");
	    resp.getWriter().println("body { font-family: 'Segoe UI', sans-serif; background-color: var(--bg-light); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }");
	    resp.getWriter().println(".status-card { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); text-align: center; border-top: 6px solid var(--fey-blue); max-width: 400px; }");
	    resp.getWriter().println(".btn { display: inline-block; margin-top: 20px; padding: 10px 20px; background: var(--fey-blue); color: white; text-decoration: none; border-radius: 6px; font-weight: bold; }");
	    resp.getWriter().println("</style></head><body><div class='status-card'>");

	    try {
	        Connection con = DBConnection.getInstance().getConnection();
	        if (con != null) {
	            resp.getWriter().println("<h2 style='color: #166534;'>✅ Database Connected</h2>");
	            resp.getWriter().println("<p>The system is communicating with the server successfully.</p>");
	            con.close(); // close test connections
	        } else {
	            resp.getWriter().println("<h2 style='color: #dc2626;'>❌ Connection Failed</h2>");
	            resp.getWriter().println("<p>The database returned a null connection.</p>");
	        }
	    } catch (java.sql.SQLException e) {
	        resp.getWriter().println("<h2 style='color: #dc2626;'>❌ SQL Error</h2>");
	        resp.getWriter().println("<p style='font-family: monospace; font-size: 0.8em; background: #fff1f2; padding: 10px;'>" + e.getMessage() + "</p>");
	    }

	    resp.getWriter().println("<a href='system/dashboard.jsp' class='btn'>Back to Dashboard</a>");
	    resp.getWriter().println("</div></body></html>");
	}
}
