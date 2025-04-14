package com.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.dao.UserDAO;
import com.user.UserDetails;
import com.db.DBConnect;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDetails user = (UserDetails) session.getAttribute("user");

        if (user != null) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("register.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDetails user = (UserDetails) session.getAttribute("user");

        if (user != null) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");

            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setAddress(address);
            user.setPhoneNumber(phoneNumber);

            try {
                UserDAO userDao = new UserDAO(DBConnect.getConn());
                boolean updated = userDao.updateUserProfile(user);

                if (updated) {
                    session.setAttribute("update-success", "Profile updated successfully.");
                } else {
                    session.setAttribute("update-failed", "Failed to update profile. Please try again.");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                session.setAttribute("update-failed", "Database connection error: " + e.getMessage());
            }

            session.setAttribute("user", user); // Update user object in session
            response.sendRedirect("profile.jsp"); // Redirect to profile.jsp
        } else {
            response.sendRedirect("register.jsp");
        }
    }
}
