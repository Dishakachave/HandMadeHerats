package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;


import com.dao.UserDAO;
import com.db.DBConnect;
import com.user.UserDetails;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("fname");
        String email = request.getParameter("uemail");
        String password = request.getParameter("upassword");
        String securityQuestion = request.getParameter("securityQuestion");
        String securityAnswer = request.getParameter("securityAnswer");

        UserDetails us = new UserDetails();
        us.setName(name);
        us.setEmail(email);
        us.setPassword(password);
        us.setSecurityQuestion(securityQuestion);
        us.setSecurityAnswer(securityAnswer);
        us.setRole("user"); // Default role


        HttpSession session = request.getSession();
        Connection conn = null;

        try {
            conn = DBConnect.getConn();
            UserDAO dao = new UserDAO(conn);
            boolean userExists = dao.isUserExist(email);

            if (userExists) {
                session.setAttribute("failed-msg", "User already exists. Please login.");
            } else {
                boolean f = dao.addUser(us);
                if (f) {
                    // Retrieve the generated user id
                    String query = "SELECT id FROM user WHERE email='" + email + "'";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);

                    if (rs.next()) {
                        int userId = rs.getInt("id");
                        us.setId(userId); // Set the id in UserDetails object
                    }

                    session.setAttribute("reg-success", "Registration successful. Now please login.");
                } else {
                    session.setAttribute("failed-msg", "Something went wrong on the server.");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            session.setAttribute("failed-msg", "Database connection error: " + e.getMessage());
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("register.jsp?showLogin=true");
    }
}
