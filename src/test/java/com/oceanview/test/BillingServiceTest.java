package com.oceanview.test;

import com.oceanview.model.Reservation;
import com.oceanview.service.BillingService;
import org.junit.jupiter.api.*;

import java.text.SimpleDateFormat;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.*;

public class BillingServiceTest {

    private static BillingService billingService;
    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @BeforeAll
    public static void setup() {
        billingService = new BillingService();
    }

    @Test
    public void testCalculateTotalStayCost() throws Exception {
        Date checkIn = sdf.parse("2026-03-01");
        Date checkOut = sdf.parse("2026-03-05"); // 4 nights
        Reservation res = new Reservation("Jane Doe", "Colombo", "0712345678", "Deluxe", checkIn, checkOut);
        double total = billingService.calculateTotalStayCost(res);
        assertEquals(150 * 4, total); // Deluxe $150/night
    }

    @Test
    public void testMinimumOneNight() throws Exception {
        Date checkIn = sdf.parse("2026-03-01");
        Date checkOut = sdf.parse("2026-03-01"); // same day
        Reservation res = new Reservation("Jane Doe", "Colombo", "0712345678", "Single", checkIn, checkOut);
        double total = billingService.calculateTotalStayCost(res);
        assertEquals(100, total); // Single $100 minimum
    }
}
