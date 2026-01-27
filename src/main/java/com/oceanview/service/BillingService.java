package com.oceanview.service;

import com.oceanview.model.Reservation;
import com.oceanview.util.RoomRateFactory;
import java.util.concurrent.TimeUnit;

public class BillingService {
    
    public double calculateTotalStayCost(Reservation res) {
        if (res == null || res.getCheckInDate() == null || res.getCheckOutDate() == null) {
            return 0.0;
        }

        long diffInMillies = Math.abs(res.getCheckOutDate().getTime() - res.getCheckInDate().getTime());
        long nights = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
        
        // Scenario: Minimum 1 night charge
        if (nights <= 0) nights = 1;

        double rate = RoomRateFactory.getRate(res.getRoomType());
        return nights * rate;
    }
}