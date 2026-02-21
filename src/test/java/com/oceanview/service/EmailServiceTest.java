package com.oceanview.service;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class EmailServiceTest {
    private final EmailService emailService = new EmailService();

    @Test
    void testEmailContentGeneration() {
        assertDoesNotThrow(() -> 
            emailService.sendBookingConfirmation("test@user.com", "Guest Name", "RSV-0001")
        );
    }

    @Test
    void testInvalidEmailHandling() {
        assertDoesNotThrow(() -> 
            emailService.sendBookingConfirmation("", "Guest", "001")
        );
    }

    @Test
    void testServiceInitialization() {
        assertNotNull(emailService);
    }
}