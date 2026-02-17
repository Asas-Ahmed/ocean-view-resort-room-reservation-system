package com.oceanview.dao;
import com.oceanview.model.Reservation;
import java.util.List;

public interface IReservationDAO {
	int addReservation(Reservation res) throws Exception;    
	boolean deleteReservation(int id) throws Exception;
    boolean updateReservation(Reservation res) throws Exception;
    List<Reservation> getAllReservations() throws Exception;
    Reservation getReservationById(int id) throws Exception;
    int getTotalReservationsCount() throws Exception;
    int getArrivalsTodayCount() throws Exception;
    List<Reservation> searchReservations(String query) throws Exception;
}