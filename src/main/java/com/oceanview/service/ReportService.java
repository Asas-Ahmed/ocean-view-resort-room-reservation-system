package com.oceanview.service;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import java.util.List;
import java.util.stream.Collectors;

public class ReportService {
    private final ReservationDAO dao = new ReservationDAO();

    public long getTotalReservations() throws Exception {
        return dao.getAllReservations().size();
    }

    public List<Reservation> getReservationsByRoomType(String type) throws Exception {
        return dao.getAllReservations()
                  .stream()
                  .filter(r -> r.getRoomType().equalsIgnoreCase(type))
                  .collect(Collectors.toList());
    }
}