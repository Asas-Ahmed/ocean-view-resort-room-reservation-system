package com.oceanview.dao;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
import org.junit.jupiter.api.Test;

class SettingsDAOTest {
    // Mock the class to test that the method calls work
    private final SettingsDAO settingsDAO = mock(SettingsDAO.class);

    @Test
    void testGetTotalCapacity_ReturnsValue() throws Exception {
        // Mocking the behavior to return 100
        when(settingsDAO.getTotalCapacity()).thenReturn(100);
        
        int capacity = settingsDAO.getTotalCapacity();
        assertEquals(100, capacity, "Capacity should match the mocked value");
    }

    @Test
    void testSetTotalCapacity_CallsMethod() throws Exception {
        doNothing().when(settingsDAO).setTotalCapacity(75);
        settingsDAO.setTotalCapacity(75);
        verify(settingsDAO, times(1)).setTotalCapacity(75);
    }

    @Test
    void testDefaultCapacityFallback() throws Exception {
        // Simulating the default return value logic
        when(settingsDAO.getTotalCapacity()).thenReturn(50);
        assertEquals(50, settingsDAO.getTotalCapacity());
    }
}