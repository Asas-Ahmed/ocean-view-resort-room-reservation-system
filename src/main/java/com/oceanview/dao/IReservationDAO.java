package com.oceanview.dao;
import com.oceanview.model.Reservation;
import java.util.List;

public interface IReservationDAO {
    boolean addReservation(Reservation res);
    boolean deleteReservation(int id);
    boolean updateReservation(Reservation res);
    List<Reservation> getAllReservations();
    Reservation getReservationById(int id);
}