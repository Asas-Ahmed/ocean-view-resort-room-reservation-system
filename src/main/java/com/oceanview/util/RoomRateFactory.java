package com.oceanview.util;

public class RoomRateFactory {
    public static double getRate(String roomType) {
        if (roomType == null) return 15000.0;
        
        return switch (roomType.toLowerCase()) {
            case "suite" -> 55000.0;     // Premium Suite
            case "deluxe", "double" -> 35000.0;  // High-end Deluxe
            case "standard", "single" -> 18000.0; // Base Standard
            default -> 15000.0;
        };
    }
}