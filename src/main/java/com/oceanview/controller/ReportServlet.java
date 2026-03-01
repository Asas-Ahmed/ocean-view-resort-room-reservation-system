package com.oceanview.controller;

import com.oceanview.model.User;
import com.oceanview.model.Reservation;
import com.oceanview.service.ReportService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/system/export")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReportService reportService = new ReportService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Security Check (Admin Only)
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized access");
            return;
        }

        // Get Parameters
        String start = request.getParameter("startDate");
        String end = request.getParameter("endDate");
        String format = request.getParameter("format");

        // Create Dynamic Filename
        String baseName = "OceanView_Report_" + start + "_to_" + end;

        try {
            List<Reservation> data = reportService.getReportData(start, end);
            
            if ("csv".equals(format)) {
                response.setContentType("text/csv");
                response.setHeader("Content-Disposition", "attachment; filename=" + baseName + ".csv");
                reportService.generateCSV(response.getOutputStream(), data);
            } else {
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=" + baseName + ".pdf");
                reportService.generatePDF(response.getOutputStream(), data);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Report generation failed.");
        }
    }
}