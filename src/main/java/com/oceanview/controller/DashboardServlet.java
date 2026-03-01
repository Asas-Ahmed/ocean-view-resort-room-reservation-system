package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.SettingsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/system/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO = new ReservationDAO();
    private SettingsDAO settingsDAO = new SettingsDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
                return;
            }

            int totalRes = reservationDAO.getTotalReservationsCount();
            int arrivalsToday = reservationDAO.getArrivalsTodayCount();
            int totalCapacity = settingsDAO.getTotalCapacity(); 
            int availableRooms = totalCapacity - totalRes;
            int standardCount = reservationDAO.getCountByRoomType("Standard");
            int deluxeCount = reservationDAO.getCountByRoomType("Deluxe");
            int suiteCount = reservationDAO.getCountByRoomType("Suite");
            List<Double> revenueTrend = reservationDAO.getRevenueTrend();
            double projectedRevenue = (standardCount * 100) + (deluxeCount * 200) + (suiteCount * 500);

            request.setAttribute("revenueData", revenueTrend);
            request.setAttribute("stdCount", standardCount);
            request.setAttribute("dlxCount", deluxeCount);
            request.setAttribute("steCount", suiteCount);
            request.setAttribute("revenue", projectedRevenue);
            
            request.setAttribute("totalRes", totalRes);
            request.setAttribute("arrivalsToday", arrivalsToday);
            request.setAttribute("totalCapacity", totalCapacity); 
            request.setAttribute("availableRooms", Math.max(0, availableRooms));

            request.getRequestDispatcher("/system/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Dashboard Load Failure", e);
        }
    }
}