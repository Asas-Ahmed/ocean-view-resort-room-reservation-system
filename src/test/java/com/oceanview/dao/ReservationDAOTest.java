package com.oceanview.dao;

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
    public void testGetAllReservations() throws Exception {
        List<Reservation> reservations = dao.getAllReservations();
        assertNotNull(reservations);
    }

    @Test
    public void testAddAndDeleteReservation() throws Exception {
        Date checkIn = sdf.parse("2026-04-01");
        Date checkOut = sdf.parse("2026-04-03");
        Reservation res = new Reservation("DB Test", "dbtest@example.com", "Test City", "0712345678", "Standard", checkIn, checkOut);
        int newId = dao.addReservation(res);
        assertTrue(newId > 0);
        boolean deleted = dao.deleteReservation(newId);
        assertTrue(deleted);
    }
}