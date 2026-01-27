package com.oceanview.util;

public class RoomRateFactory {
    public static double getRate(String roomType) {
        if (roomType == null) return 80.0;
        return switch (roomType.toLowerCase()) {
            case "suite" -> 200.0;
            case "deluxe", "double" -> 150.0;
            case "standard", "single" -> 100.0;
            default -> 80.0;
        };
    }
}