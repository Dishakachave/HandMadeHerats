package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.user.UserDetails;

public class UserDAO {
    private Connection conn;

    public UserDAO(Connection conn) {
        super();
        this.conn = conn;
    }

    public boolean addUser(UserDetails us) {
        boolean f = false;
        try {
            if (!isUserExist(us.getEmail())) {
                String query = "insert into user(name, email, password, security_question, security_answer, role) values(?,?,?,?,?,?)";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, us.getName());
                ps.setString(2, us.getEmail());
                ps.setString(3, us.getPassword());
                ps.setString(4, us.getSecurityQuestion());
                ps.setString(5, us.getSecurityAnswer());
                ps.setString(6, us.getRole());
                int i = ps.executeUpdate();
                if (i == 1) {
                    f = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean isUserExist(String email) {
        boolean f = false;
        try {
            String query = "select * from user where email=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public UserDetails loginUser(String email, String password) {
        UserDetails user = null;
        try {
            String query = "select * from user where email=? and password=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new UserDetails();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setSecurityQuestion(rs.getString("security_question"));
                user.setSecurityAnswer(rs.getString("security_answer"));
                user.setRole(rs.getString("role"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setAddress(rs.getString("address"));
                user.setPhoneNumber(rs.getString("phone_number"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean resetPassword(String email, String securityQuestion, String securityAnswer, String newPassword) {
        boolean f = false;
        try {
            String query = "select * from user where email=? and security_question=? and security_answer=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, securityQuestion);
            ps.setString(3, securityAnswer);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String updateQuery = "update user set password=? where email=?";
                PreparedStatement updatePs = conn.prepareStatement(updateQuery);
                updatePs.setString(1, newPassword);
                updatePs.setString(2, email);
                int i = updatePs.executeUpdate();
                if (i == 1) {
                    f = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean updateUserProfile(UserDetails user) {
        boolean updated = false;
        try {
            String query = "UPDATE user SET first_name=?, last_name=?, address=?, phone_number=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getAddress());
            ps.setString(4, user.getPhoneNumber());
            ps.setInt(5, user.getId());
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                updated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updated;
    }
}
