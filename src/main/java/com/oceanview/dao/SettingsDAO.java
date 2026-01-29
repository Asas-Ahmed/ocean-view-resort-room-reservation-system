package com.oceanview.dao;

import com.oceanview.util.DBConnection;
import java.sql.*;

public class SettingsDAO {

    public int getTotalCapacity() throws Exception {
        String sql = "SELECT config_value FROM system_settings WHERE config_key = 'total_capacity'";
        try (Connection con = DBConnection.getInstance().getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return Integer.parseInt(rs.getString("config_value"));
        }
        return 50; 
    }
    
    public void setTotalCapacity(int newCount) throws Exception {
        String sql = "UPDATE system_settings SET config_value = ? WHERE config_key = 'total_capacity'";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, String.valueOf(newCount));
            ps.executeUpdate();
        }
    }
}