package com.oceanview.service;

import com.oceanview.dao.IReservationDAO;
import com.oceanview.model.Reservation;
import java.util.List;

/**
 * Service Layer - Implements Business Logic.
 * Pattern: Service Layer Pattern
 * SOLID: Dependency Inversion (depends on IReservationDAO interface)
 */
public class ReservationService {
    private final IReservationDAO reservationDAO;
    private final BillingService billingService = new BillingService();

    // Constructor Injection for the DAO
    public ReservationService(IReservationDAO reservationDAO) {
        this.reservationDAO = reservationDAO;
    }

    /**
     * Delegates calculation to the BillingService.
     * SOLID: Single Responsibility Principle.
     */
    public double calculateBill(Reservation res) {
        return billingService.calculateTotalStayCost(res);
    }

    // CRUD operations delegating to the DAO
    public Reservation getReservationById(int id) { 
        return reservationDAO.getReservationById(id); 
    }

    public boolean addReservation(Reservation r) { 
        // Logic: Basic validation before sending to DB
        if (r == null || r.getGuestName() == null || r.getGuestName().trim().isEmpty()) {
            return false;
        }
        return reservationDAO.addReservation(r); 
    }

    public List<Reservation> getAllReservations() { 
        return reservationDAO.getAllReservations(); 
    }

    public boolean deleteReservation(int id) { 
        return reservationDAO.deleteReservation(id); 
    }

    public boolean updateReservation(Reservation r) { 
        return reservationDAO.updateReservation(r); 
    }
}