package com.oceanview.controller;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;
import com.oceanview.service.ReservationService;
import com.oceanview.model.Reservation;
import jakarta.servlet.http.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

class ApiReservationServletTest {

    private ApiReservationServlet servlet;
    private ReservationService mockService;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private StringWriter stringWriter;
    private PrintWriter writer;

    @BeforeEach
    void setUp() throws Exception {
        servlet = new ApiReservationServlet();
        mockService = mock(ReservationService.class);
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        
        // Setup the writer for every test to avoid NPE
        stringWriter = new StringWriter();
        writer = new PrintWriter(stringWriter);
        when(response.getWriter()).thenReturn(writer);

        // Inject the mock service
        Field field = ApiReservationServlet.class.getDeclaredField("service");
        field.setAccessible(true);
        field.set(servlet, mockService);
    }

    @Test
    void testGetAvailability_ReturnsJson() throws Exception {
        // Prepare mock data
        List<Reservation> mockList = new ArrayList<>();
        mockList.add(new Reservation(1, "John Doe", "john@email.com", "123 St", "555", "Deluxe", null, null));
        when(mockService.getAllReservations()).thenReturn(mockList);

        servlet.doGet(request, response);
        
        verify(response).setContentType("application/json");
        String result = stringWriter.toString();
        // Check for "guest" or "id" instead of "available"
        assertTrue(result.contains("John Doe"), "JSON should contain the guest name");
    }

    @Test
    void testApiErrorHandling() throws Exception {
        // Simulate a service failure
        when(mockService.getAllReservations()).thenThrow(new RuntimeException("DB Error"));

        servlet.doGet(request, response);
        
        verify(response).setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        assertTrue(stringWriter.toString().contains("error"), "Should return error JSON");
    }

    @Test
    void testPostResponseCode() throws Exception {
        // Setup parameters for POST
        when(request.getParameter("guestName")).thenReturn("Jane Doe");
        when(request.getParameter("checkInDate")).thenReturn("2026-05-01");
        when(request.getParameter("checkOutDate")).thenReturn("2026-05-05");
        
        // Mock success
        when(mockService.addReservation(any())).thenReturn(101);

        servlet.doPost(request, response);
        
        verify(response).setStatus(HttpServletResponse.SC_CREATED);
        assertTrue(stringWriter.toString().contains("successfully"));
    }
}