package com.oceanview.test;

import com.oceanview.util.RoomRateFactory;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class RoomRateFactoryTest {
    @Test 
    void testDeluxeRate() {
        assertEquals(35000.0, RoomRateFactory.getRate("Deluxe"), "Deluxe rate should be 35000");
    }

    @Test 
    void testSuiteRate() {
        double actualSuiteRate = RoomRateFactory.getRate("Suite");
        assertTrue(actualSuiteRate > 0, "Suite rate should be a positive value");
    }

    @Test 
    void testInvalidRoom() {
        assertEquals(15000.0, RoomRateFactory.getRate("Unknown"), "Unknown rooms should return default rate of 15000");
    }
}