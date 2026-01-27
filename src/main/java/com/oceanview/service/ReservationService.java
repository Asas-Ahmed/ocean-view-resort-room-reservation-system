package com.oceanview.service;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import java.util.List;

public class ReservationService {
    private final ReservationDAO reservationDAO;

    // Dependency Injection for easier testing and maintainability
    public ReservationService() {
        this.reservationDAO = new ReservationDAO();
    }

    public ReservationService(ReservationDAO reservationDAO) {
        this.reservationDAO = reservationDAO;
    }

    // Add a new reservation
    public boolean addReservation(Reservation reservation) {
        if (reservation == null || reservation.getGuestName() == null || reservation.getGuestName().isEmpty()) {
            throw new IllegalArgumentException("Guest name is required");
        }
        return reservationDAO.addReservation(reservation);
    }

    // Get reservation by ID
    public Reservation getReservationById(int id) {
        return reservationDAO.getReservationById(id);
    }

    // Get all reservations
    public List<Reservation> getAllReservations() {
        return reservationDAO.getAllReservations();
    }

    // Business logic: Calculate bill based on room type and stay duration
    public double calculateBill(Reservation reservation) {
        if (reservation == null) return 0;
        long diff = reservation.getCheckOutDate().getTime() - reservation.getCheckInDate().getTime();
        int nights = (int) (diff / (1000 * 60 * 60 * 24));
        double rate = getRoomRate(reservation.getRoomType());
        return nights * rate;
    }

    private double getRoomRate(String roomType) {
        switch (roomType.toLowerCase()) {
            case "suite": return 200.0;
            case "deluxe": return 150.0;
            case "standard": return 100.0;
            default: return 80.0;
        }
    }
}
