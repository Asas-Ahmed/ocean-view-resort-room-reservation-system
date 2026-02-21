package com.oceanview.test;
import com.oceanview.model.Reservation;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import java.util.Date;

class ReservationTest {
    @Test void testFormattedId() {
        Reservation res = new Reservation();
        res.setReservationId(5);
        assertEquals("RES-0005", res.getFormattedReservationId());
    }
    @Test void testDataIntegrity() {
        Date d = new Date();
        Reservation res = new Reservation("John", "j@mail.com", "Col", "123", "Deluxe", d, d);
        assertEquals("John", res.getGuestName());
    }
    @Test void testSetId() {
        Reservation res = new Reservation();
        res.setReservationId(99);
        assertEquals(99, res.getReservationId());
    }
}