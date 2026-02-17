package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import com.oceanview.service.EmailService;
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
    private EmailService emailService;
    private final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    public void init() {
        // Initializing services with their dependencies
        this.reservationService = new ReservationService(new ReservationDAO());
        this.emailService = new EmailService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");

            // Common form data for both Add and Update
            String guestName = req.getParameter("guestName");
            String guestEmail = req.getParameter("guestEmail");
            String address = req.getParameter("address");
            String contactNumber = req.getParameter("contactNumber");
            String roomType = req.getParameter("roomType");
            Date checkIn = sdf.parse(req.getParameter("checkInDate"));
            Date checkOut = sdf.parse(req.getParameter("checkOutDate"));

            if ("update".equals(action)) {
                // HANDLE UPDATE
                int id = Integer.parseInt(req.getParameter("reservationId"));
                Reservation res = new Reservation(id, guestName, guestEmail, address, contactNumber, roomType, checkIn, checkOut);
                
                reservationService.updateReservation(res);
                resp.sendRedirect("reservation?msg=Reservation+updated+successfully");
                
            } else {
                // HANDLE NEW ADD
                Reservation res = new Reservation(guestName, guestEmail, address, contactNumber, roomType, checkIn, checkOut);
                int generatedId = reservationService.addReservation(res);

                if (generatedId > 0) {
                    // TRIGGER EMAIL NOTIFICATION if email exists
                    if (guestEmail != null && !guestEmail.isEmpty()) {
                        String reservationNo = String.format("RSV-%04d", generatedId);
                        emailService.sendBookingConfirmation(guestEmail, guestName, reservationNo);
                    }
                    resp.sendRedirect(req.getContextPath() + "/reservation?msg=Reservation+added+successfully");
                } else {
                    req.setAttribute("error", "Database Error: Could not save reservation.");
                    req.getRequestDispatcher("reservations/add.jsp").forward(req, resp);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle parsing errors or critical failures
            if (e instanceof java.text.ParseException || e instanceof NumberFormatException) {
                req.setAttribute("error", "Input Error: Please check your dates and numbers.");
                String action = req.getParameter("action");
                if ("update".equals(action)) {
                    req.getRequestDispatcher("reservations/edit.jsp").forward(req, resp);
                } else {
                    req.getRequestDispatcher("reservations/add.jsp").forward(req, resp);
                }
            } else {
                throw new ServletException("Critical System Error during POST", e);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");
            String idParam = req.getParameter("id");

            // HANDLE DELETE
            if ("delete".equals(action) && idParam != null) {
                reservationService.deleteReservation(Integer.parseInt(idParam));
                resp.sendRedirect("reservation?msg=Reservation+Deleted");
                return;
            }

            // HANDLE EDIT (Fetch single record for edit form)
            if ("edit".equals(action) && idParam != null) {
                Reservation res = reservationService.getReservationById(Integer.parseInt(idParam));
                req.setAttribute("res", res);
                req.getRequestDispatcher("reservations/edit.jsp").forward(req, resp);
                return;
            }

            // DEFAULT: VIEW ALL
            List<Reservation> reservations = reservationService.getAllReservations();
            req.setAttribute("reservations", reservations);
            req.getRequestDispatcher("reservations/viewAll.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Reservation System Error during GET", e);
        }
    }
}