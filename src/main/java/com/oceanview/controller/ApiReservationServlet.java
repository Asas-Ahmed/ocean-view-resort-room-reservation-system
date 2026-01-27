package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/reservations")
public class ApiReservationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ReservationService service = new ReservationService(new ReservationDAO());

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        List<Reservation> list = service.getAllReservations();
        
        // Manual JSON construction to avoid external library issues for the demo
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            Reservation r = list.get(i);
            json.append(String.format("{\"id\":%d, \"guest\":\"%s\"}", r.getReservationId(), r.getGuestName()));
            if (i < list.size() - 1) json.append(",");
        }
        json.append("]");
        resp.getWriter().write(json.toString());
    }
}