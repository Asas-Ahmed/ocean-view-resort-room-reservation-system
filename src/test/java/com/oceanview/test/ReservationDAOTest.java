package com.oceanview.test;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import org.junit.jupiter.api.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class ReservationDAOTest {

    private static ReservationDAO dao;
    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @BeforeAll
    public static void setup() {
        dao = new ReservationDAO();
    }

    @Test
    public void testGetAllReservations() {
        List<Reservation> reservations = dao.getAllReservations();
        assertNotNull(reservations);
    }

    @Test
    public void testAddAndDeleteReservation() throws Exception {
        Date checkIn = sdf.parse("2026-04-01");
        Date checkOut = sdf.parse("2026-04-03");
        Reservation res = new Reservation("DB Test", "Test City", "0712345678", "Standard", checkIn, checkOut);
        boolean added = dao.addReservation(res);
        assertTrue(added);

        List<Reservation> list = dao.getAllReservations();
        Reservation last = list.get(list.size() - 1);

        boolean deleted = dao.deleteReservation(last.getReservationId());
        assertTrue(deleted);
    }
}
