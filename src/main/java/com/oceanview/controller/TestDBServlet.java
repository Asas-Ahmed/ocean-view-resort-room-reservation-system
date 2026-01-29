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
	    resp.setContentType("text/plain"); // Simple text response
	    try (Connection con = DBConnection.getInstance().getConnection()) {
	        if (con != null && !con.isClosed()) {
	            resp.getWriter().write("ONLINE");
	        } else {
	            resp.setStatus(500);
	            resp.getWriter().write("OFFLINE");
	        }
	    } catch (Exception e) {
	        resp.setStatus(500);
	        resp.getWriter().write("ERROR");
	    }
	}
}
