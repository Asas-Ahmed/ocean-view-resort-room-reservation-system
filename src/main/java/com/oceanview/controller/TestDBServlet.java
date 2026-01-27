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
        Connection con = DBConnection.getConnection();

        if (con != null) {
            resp.getWriter().println("<h2>✅ Database Connected Successfully</h2>");
        } else {
            resp.getWriter().println("<h2>❌ Database Connection Failed</h2>");
        }
    }
}
