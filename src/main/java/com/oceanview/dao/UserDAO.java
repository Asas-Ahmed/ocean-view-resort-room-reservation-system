package com.oceanview.dao;

import com.oceanview.model.User;
import com.oceanview.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public User getUserByUsername(String username) throws Exception {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(rs.getInt("user_id"), rs.getString("username"), 
                                    rs.getString("password"), rs.getString("role"));
                }
            }
        }
        return null;
    }

    public boolean addUser(User user) throws Exception {
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, hashedPassword);
            ps.setString(3, user.getRole());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateUser(String username, String password, String role) throws Exception {
        boolean hasNewPassword = (password != null && !password.trim().isEmpty());
        String sql = hasNewPassword ? 
            "UPDATE users SET password = ?, role = ? WHERE username = ?" : 
            "UPDATE users SET role = ? WHERE username = ?";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            if (hasNewPassword) {
                ps.setString(1, BCrypt.hashpw(password, BCrypt.gensalt()));
                ps.setString(2, role);
                ps.setString(3, username);
            } else {
                ps.setString(1, role);
                ps.setString(2, username);
            }
            return ps.executeUpdate() > 0;
        }
    }

    public List<User> getAllUsers() throws Exception {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection con = DBConnection.getInstance().getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new User(rs.getInt("user_id"), rs.getString("username"), 
                                  rs.getString("password"), rs.getString("role")));
            }
        }
        return list;
    }

    public boolean deleteUser(String username) throws Exception {
        String sql = "DELETE FROM users WHERE username = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            return ps.executeUpdate() > 0;
        }
    }
}