package com.oceanview.factory;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.service.ReservationService;

public class ServiceFactory {

    private ServiceFactory() {}

    public static ReservationService getReservationService() {
        return new ReservationService(new ReservationDAO());
    }
}
