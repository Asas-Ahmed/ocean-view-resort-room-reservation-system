package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ReservationService reservationService;

    @Override
    public void init() {
        this.reservationService = new ReservationService(new ReservationDAO());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rawId = request.getParameter("reservationId");
        int cleanId = 0;

        try {
            if (rawId != null && !rawId.trim().isEmpty()) {
                String temp = rawId.trim().toUpperCase();
                if (temp.startsWith("RES-")) {
                    temp = temp.substring(4);
                }
                cleanId = Integer.parseInt(temp);
            }

            Reservation res = reservationService.getReservationById(cleanId);

            if (res != null) {
                double total = reservationService.calculateBill(res);
                
                request.setAttribute("reservation", res);
                request.setAttribute("totalBill", total);

                request.getRequestDispatcher("/billing/invoice.jsp").forward(request, response);
            } else {
            	response.sendRedirect(request.getContextPath() + "/reservations/search.jsp?error=NotFound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("search.jsp?error=InvalidFormat");
        }
    }
}