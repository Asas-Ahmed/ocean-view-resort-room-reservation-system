package com.oceanview.service;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import java.util.List;
import java.util.stream.Collectors;
import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import java.io.OutputStream;

public class ReportService {
    private final ReservationDAO dao = new ReservationDAO();

    public long getTotalReservations() throws Exception {
        return dao.getAllReservations().size();
    }

    public List<Reservation> getReservationsByRoomType(String type) throws Exception {
        return dao.getAllReservations()
                  .stream()
                  .filter(r -> r.getRoomType().equalsIgnoreCase(type))
                  .collect(Collectors.toList());
    }
    
    public List<Reservation> getReportData(String start, String end) throws Exception {
        return dao.getReservationsByRange(start, end);
    }

    // CSV Generation
    public void generateCSV(OutputStream out, List<Reservation> data) throws Exception {
        StringBuilder sb = new StringBuilder();
        sb.append("ID,Guest Name,Email,Room Type,Check-In,Check-Out\n");
        for (Reservation r : data) {
            sb.append(String.format("%d,%s,%s,%s,%s,%s\n", 
                r.getReservationId(), r.getGuestName(), r.getGuestEmail(), 
                r.getRoomType(), r.getCheckInDate(), r.getCheckOutDate()));
        }
        out.write(sb.toString().getBytes());
    }

    // PDF Generation
    public void generatePDF(OutputStream out, List<Reservation> data) throws Exception {
        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, out);
        document.open();
        
        document.add(new Paragraph("Ocean View Resort - Reservation Report", 
                FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18)));
        document.add(new Paragraph(" ")); // Spacer

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);
        String[] headers = {"ID", "Guest", "Room", "Check-In", "Check-Out"};
        for(String h : headers) table.addCell(new PdfPCell(new Phrase(h)));

        for (Reservation r : data) {
            table.addCell(String.valueOf(r.getReservationId()));
            table.addCell(r.getGuestName());
            table.addCell(r.getRoomType());
            table.addCell(r.getCheckInDate().toString());
            table.addCell(r.getCheckOutDate().toString());
        }
        document.add(table);
        document.close();
    }
}