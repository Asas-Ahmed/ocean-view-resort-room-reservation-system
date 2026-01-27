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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    private ReservationService reservationService;
    private final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    public void init() {
        // Initialize once to save memory
        this.reservationService = new ReservationService(new ReservationDAO());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action"); // Check if it's an update or new add

            // 1. Capture Form Data
            String guestName = req.getParameter("guestName");
            String address = req.getParameter("address");
            String contactNumber = req.getParameter("contactNumber");
            String roomType = req.getParameter("roomType");
            Date checkInDate = sdf.parse(req.getParameter("checkInDate"));
            Date checkOutDate = sdf.parse(req.getParameter("checkOutDate"));

            if ("update".equals(action)) {
                // HANDLE UPDATE
                int id = Integer.parseInt(req.getParameter("reservationId"));
                Reservation reservation = new Reservation(id, guestName, address, contactNumber, roomType, checkInDate, checkOutDate);
                reservationService.updateReservation(reservation);
                resp.sendRedirect("reservation?msg=Reservation+updated+successfully");
            } else {
                // HANDLE NEW ADD
                Reservation reservation = new Reservation(guestName, address, contactNumber, roomType, checkInDate, checkOutDate);
                boolean success = reservationService.addReservation(reservation);
                if (success) {
                    resp.sendRedirect("system/dashboard.jsp?msg=Reservation+added+successfully");
                } else {
                    req.setAttribute("error", "Failed to save to database.");
                    req.getRequestDispatcher("reservations/add.jsp").forward(req, resp);
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", "Input Error: " + e.getMessage());
            req.getRequestDispatcher("reservations/add.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String idParam = req.getParameter("id");

        // 1. HANDLE DELETE
        if ("delete".equals(action) && idParam != null) {
            reservationService.deleteReservation(Integer.parseInt(idParam));
            resp.sendRedirect("reservation?msg=Reservation+Deleted");
            return;
        }

        // 2. HANDLE EDIT (Fetch data and go to Edit Page)
        if ("edit".equals(action) && idParam != null) {
            Reservation res = reservationService.getReservationById(Integer.parseInt(idParam));
            req.setAttribute("res", res);
            req.getRequestDispatcher("reservations/edit.jsp").forward(req, resp);
            return;
        }

        // 3. DEFAULT: VIEW ALL
        List<Reservation> reservations = reservationService.getAllReservations();
        req.setAttribute("reservations", reservations);
        req.getRequestDispatcher("reservations/viewAll.jsp").forward(req, resp);
    }
}