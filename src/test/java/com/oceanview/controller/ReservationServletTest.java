package com.oceanview.controller;

import static org.mockito.Mockito.*;
import com.oceanview.service.ReservationService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.lang.reflect.Field;
import java.util.ArrayList;

class ReservationServletTest {

    private ReservationServlet servlet;
    private ReservationService mockService;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;

    @BeforeEach
    void setUp() throws Exception {
        servlet = new ReservationServlet();
        mockService = mock(ReservationService.class);
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);
        Field field = ReservationServlet.class.getDeclaredField("reservationService");
        field.setAccessible(true);
        field.set(servlet, mockService);
    }

    @Test
    void testDoGet_ViewAll_SetsReservationsAttribute() throws Exception {
        when(request.getRequestDispatcher("reservations/viewAll.jsp")).thenReturn(dispatcher);
        when(mockService.getAllReservations()).thenReturn(new ArrayList<>());

        servlet.doGet(request, response);
        
        verify(request).setAttribute(eq("reservations"), any());
        verify(dispatcher).forward(request, response);
    }

    @Test
    void testDeleteAction_RedirectsWithMessage() throws Exception {
        when(request.getParameter("action")).thenReturn("delete");
        when(request.getParameter("id")).thenReturn("10");
        when(mockService.deleteReservation(10)).thenReturn(true);
        servlet.doGet(request, response);
        verify(response).sendRedirect(contains("msg="));
    }

    @Test
    void testInvalidDateInput_HandlesException() throws Exception {
        when(request.getParameter("checkInDate")).thenReturn("invalid-date");
        when(request.getParameter("checkOutDate")).thenReturn("2026-01-01");
        when(request.getRequestDispatcher("reservations/add.jsp")).thenReturn(dispatcher);
        servlet.doPost(request, response);
        verify(request).setAttribute(eq("error"), contains("Input Error"));
        verify(dispatcher).forward(request, response);
    }
}