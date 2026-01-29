package com.oceanview.dao;

import com.oceanview.model.Reservation;
import com.oceanview.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO implements IReservationDAO {

	public boolean addReservation(Reservation res) {
	    String sql = "INSERT INTO reservations (guest_name, address, contact_number, room_type, check_in, check_out) VALUES (?, ?, ?, ?, ?, ?)";
	    try (Connection con = DBConnection.getInstance().getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        
	        ps.setString(1, res.getGuestName());
	        ps.setString(2, res.getAddress());
	        ps.setString(3, res.getContactNumber());
	        ps.setString(4, res.getRoomType());
	        ps.setDate(5, new java.sql.Date(res.getCheckInDate().getTime()));
	        ps.setDate(6, new java.sql.Date(res.getCheckOutDate().getTime()));
	        
	        return ps.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public boolean deleteReservation(int id) {
	    String sql = "DELETE FROM reservations WHERE reservation_id = ?";
	    try (Connection con = DBConnection.getInstance().getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, id);
	        return ps.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	public boolean updateReservation(Reservation res) {
	    String sql = "UPDATE reservations SET guest_name=?, address=?, contact_number=?, room_type=?, check_in=?, check_out=? WHERE reservation_id=?";
	    try (Connection con = DBConnection.getInstance().getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setString(1, res.getGuestName());
	        ps.setString(2, res.getAddress());
	        ps.setString(3, res.getContactNumber());
	        ps.setString(4, res.getRoomType());
	        ps.setDate(5, new java.sql.Date(res.getCheckInDate().getTime()));
	        ps.setDate(6, new java.sql.Date(res.getCheckOutDate().getTime()));
	        ps.setInt(7, res.getReservationId());
	        return ps.executeUpdate() > 0;
	    } catch (SQLException e) { e.printStackTrace(); return false; }
	}

    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations";
        try (Connection con = DBConnection.getInstance().getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            
            while (rs.next()) {
                list.add(new Reservation(
                    rs.getInt("reservation_id"),
                    rs.getString("guest_name"),
                    rs.getString("address"),
                    rs.getString("contact_number"),
                    rs.getString("room_type"),
                    rs.getDate("check_in"),
                    rs.getDate("check_out")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Reservation getReservationById(int reservationId) {
        String sql = "SELECT * FROM reservations WHERE reservation_id = ?"; 
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, reservationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Reservation(
                        rs.getInt("reservation_id"),
                        rs.getString("guest_name"),
                        rs.getString("address"),
                        rs.getString("contact_number"),
                        rs.getString("room_type"),
                        rs.getDate("check_in"),
                        rs.getDate("check_out")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
 // Get total count of all reservations (Active Bookings)
    public int getTotalReservationsCount() {
        String sql = "SELECT COUNT(*) FROM reservations";
        try (Connection con = DBConnection.getInstance().getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // Get guests arriving today (Expected Arrivals)
    public int getArrivalsTodayCount() {
        String sql = "SELECT COUNT(*) FROM reservations WHERE check_in = CURRENT_DATE";
        try (Connection con = DBConnection.getInstance().getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // Search by ID or Name (Useful for search bar)
    public List<Reservation> searchReservations(String query) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE guest_name LIKE ? OR reservation_id LIKE ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Reservation(
                        rs.getInt("reservation_id"), rs.getString("guest_name"),
                        rs.getString("address"), rs.getString("contact_number"),
                        rs.getString("room_type"), rs.getDate("check_in"), rs.getDate("check_out")
                    ));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}