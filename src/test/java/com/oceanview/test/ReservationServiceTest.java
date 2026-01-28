package com.oceanview.test;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import org.junit.jupiter.api.*;

import java.text.SimpleDateFormat;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;

public class ReservationServiceTest {

    private static ReservationService service;
    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @BeforeAll
    public static void setup() {
        service = new ReservationService(new ReservationDAO());
    }

    @Test
    public void testAddReservationSuccess() throws Exception {
        Date checkIn = sdf.parse("2026-02-01");
        Date checkOut = sdf.parse("2026-02-03");
        Reservation res = new Reservation("John Doe", "Galle", "0712345678", "Single", checkIn, checkOut);
        assertTrue(service.addReservation(res));
    }

    @Test
    public void testAddReservationInvalidContact() throws Exception {
        Date checkIn = sdf.parse("2026-02-01");
        Date checkOut = sdf.parse("2026-02-03");
        Reservation res = new Reservation("John Doe", "Galle", "123", "Single", checkIn, checkOut);

        Exception ex = assertThrows(IllegalArgumentException.class, () -> service.addReservation(res));
        assertEquals("Invalid contact number", ex.getMessage());
    }

    @Test
    public void testCalculateBill() throws Exception {
        Date checkIn = sdf.parse("2026-02-01");
        Date checkOut = sdf.parse("2026-02-04"); // 3 nights
        Reservation res = new Reservation("John Doe", "Galle", "0712345678", "Suite", checkIn, checkOut);
        double bill = service.calculateBill(res);
        assertTrue(bill > 0);
    }
}
