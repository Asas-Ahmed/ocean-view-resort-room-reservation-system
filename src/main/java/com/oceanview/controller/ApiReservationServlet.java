package com.oceanview.controller;

import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import com.oceanview.factory.ServiceFactory;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/api/reservations")
public class ApiReservationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ReservationService service;

    @Override
    public void init() {
        service = ServiceFactory.getReservationService();
    }

    // GET: Return all reservations as JSON
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        try {
            List<Reservation> list = service.getAllReservations();
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < list.size(); i++) {
                Reservation r = list.get(i);
                json.append(String.format(
                    "{\"id\":%d,\"guest\":\"%s\",\"address\":\"%s\",\"contact\":\"%s\",\"room\":\"%s\",\"checkIn\":\"%s\",\"checkOut\":\"%s\"}",
                    r.getReservationId(),
                    r.getGuestName(),
                    r.getAddress(),
                    r.getContactNumber(),
                    r.getRoomType(),
                    r.getCheckInDate(),
                    r.getCheckOutDate()
                ));
                if (i < list.size() - 1) json.append(",");
            }
            json.append("]");
            resp.getWriter().write(json.toString());
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"Failed to fetch reservations\"}");
        }
    }

    // POST: Add reservation via API
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        try {
            // Read parameters from request
            String guestName = req.getParameter("guestName");
            String address = req.getParameter("address");
            String contact = req.getParameter("contactNumber");
            String room = req.getParameter("roomType");
            Date checkIn = new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("checkInDate"));
            Date checkOut = new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("checkOutDate"));

            Reservation r = new Reservation(guestName, address, contact, room, checkIn, checkOut);
            boolean success = service.addReservation(r);

            if (success) {
                resp.setStatus(HttpServletResponse.SC_CREATED);
                resp.getWriter().write("{\"message\":\"Reservation created successfully\"}");
            } else {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"error\":\"Failed to create reservation\"}");
            }
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\":\"Invalid input data\"}");
        }
    }
}
