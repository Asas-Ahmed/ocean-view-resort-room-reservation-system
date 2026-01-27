package com.oceanview.model;

import java.util.Date;

public class Reservation {
    private int reservationId;
    private String guestName;
    private String address;
    private String contactNumber;
    private String roomType;
    private Date checkInDate;
    private Date checkOutDate;

    public Reservation() {}

    // Constructor without ID
    public Reservation(String guestName, String address, String contactNumber,
                       String roomType, Date checkInDate, Date checkOutDate) {
        this.guestName = guestName;
        this.address = address;
        this.contactNumber = contactNumber;
        this.roomType = roomType;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
    }

    // Constructor with ID
    public Reservation(int reservationId, String guestName, String address, String contactNumber,
                       String roomType, Date checkInDate, Date checkOutDate) {
        this(guestName, address, contactNumber, roomType, checkInDate, checkOutDate);
        this.reservationId = reservationId;
    }

    public String getFormattedReservationId() {
        return "RES-" + String.format("%05d", this.reservationId);
    }

    // Getters and Setters...
    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }
    public String getGuestName() { return guestName; }
    public void setGuestName(String guestName) { this.guestName = guestName; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }
    public Date getCheckInDate() { return checkInDate; }
    public void setCheckInDate(Date checkInDate) { this.checkInDate = checkInDate; }
    public Date getCheckOutDate() { return checkOutDate; }
    public void setCheckOutDate(Date checkOutDate) { this.checkOutDate = checkOutDate; }
}