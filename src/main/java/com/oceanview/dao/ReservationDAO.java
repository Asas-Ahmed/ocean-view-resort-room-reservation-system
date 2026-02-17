package com.oceanview.dao;

import com.oceanview.model.Reservation;
import com.oceanview.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO implements IReservationDAO {

	@Override
	public int addReservation(Reservation res) throws Exception {
	    String sql = "INSERT INTO reservations (guest_name, guest_email, address, contact_number, room_type, check_in, check_out) VALUES (?, ?, ?, ?, ?, ?, ?)";
	    try (Connection con = DBConnection.getInstance().getConnection(); 
	         PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
	        
	        ps.setString(1, res.getGuestName());
	        ps.setString(2, res.getGuestEmail());
	        ps.setString(3, res.getAddress());
	        ps.setString(4, res.getContactNumber());
	        ps.setString(5, res.getRoomType());
	        ps.setDate(6, new java.sql.Date(res.getCheckInDate().getTime()));
	        ps.setDate(7, new java.sql.Date(res.getCheckOutDate().getTime()));
	        
	        ps.executeUpdate();
	        try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                return generatedKeys.getInt(1);
	            }
	        }
	        return -1; 
	    }
	}

    public boolean deleteReservation(int id) throws Exception {
        String sql = "DELETE FROM reservations WHERE reservation_id = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateReservation(Reservation res) throws Exception {
        String sql = "UPDATE reservations SET guest_name=?, guest_email=?, address=?, contact_number=?, room_type=?, check_in=?, check_out=? WHERE reservation_id=?";
        try (Connection con = DBConnection.getInstance().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, res.getGuestName());
            ps.setString(2, res.getGuestEmail());
            ps.setString(3, res.getAddress());
            ps.setString(4, res.getContactNumber());
            ps.setString(5, res.getRoomType());
            ps.setDate(6, new java.sql.Date(res.getCheckInDate().getTime()));
            ps.setDate(7, new java.sql.Date(res.getCheckOutDate().getTime()));
            ps.setInt(8, res.getReservationId());
            return ps.executeUpdate() > 0;
        }
    }

    public List<Reservation> getAllReservations() throws Exception {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations";
        try (Connection con = DBConnection.getInstance().getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Reservation(
                    rs.getInt("reservation_id"), rs.getString("guest_name"), rs.getString("guest_email"),
                    rs.getString("address"), rs.getString("contact_number"),
                    rs.getString("room_type"), rs.getDate("check_in"), rs.getDate("check_out")
                ));
            }
        }
        return list;
    }

    public Reservation getReservationById(int reservationId) throws Exception {
        String sql = "SELECT * FROM reservations WHERE reservation_id = ?"; 
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, reservationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                	return new Reservation(
            		    rs.getInt("reservation_id"),
            		    rs.getString("guest_name"),
            		    rs.getString("guest_email"),
            		    rs.getString("address"),
            		    rs.getString("contact_number"),
            		    rs.getString("room_type"),
            		    rs.getDate("check_in"),
            		    rs.getDate("check_out")
            		);
                }
            }
        }
        return null;
    }

    public int getTotalReservationsCount() throws Exception {
        String sql = "SELECT COUNT(*) FROM reservations";
        try (Connection con = DBConnection.getInstance().getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public int getArrivalsTodayCount() throws Exception {
        String sql = "SELECT COUNT(*) FROM reservations WHERE check_in = CURRENT_DATE";
        try (Connection con = DBConnection.getInstance().getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public List<Reservation> searchReservations(String query) throws Exception {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE guest_name LIKE ? OR reservation_id LIKE ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Reservation(
                        rs.getInt("reservation_id"), rs.getString("guest_name"), rs.getString("guest_email"),
                        rs.getString("address"), rs.getString("contact_number"),
                        rs.getString("room_type"), rs.getDate("check_in"), rs.getDate("check_out")
                    ));
                }
            }
        }
        return list;
    }
}