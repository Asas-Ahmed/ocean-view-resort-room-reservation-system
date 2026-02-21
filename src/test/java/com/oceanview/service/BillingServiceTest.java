package com.oceanview.service;

import com.oceanview.model.Reservation;
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
        Reservation res = new Reservation("Jane Doe", "jane@example.com", "Colombo", "0712345678", "Deluxe", checkIn, checkOut);
        
        double total = billingService.calculateTotalStayCost(res);
        assertEquals(35000.0 * 4, total);
    }

    @Test
    public void testMinimumOneNight() throws Exception {
        Date checkIn = sdf.parse("2026-03-01");
        Date checkOut = sdf.parse("2026-03-01"); // 0 nights
        Reservation res = new Reservation("Jane Doe", "jane@example.com", "Colombo", "0712345678", "Single", checkIn, checkOut);
        
        double total = billingService.calculateTotalStayCost(res);
        assertEquals(18000.0, total); 
    }
}
