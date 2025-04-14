package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.dao.UserDAO;
import com.db.DBConnect;
import com.user.UserDetails;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();
        Connection conn = null;

        try {
            conn = DBConnect.getConn();
            UserDAO dao = new UserDAO(conn);
            UserDetails user = dao.loginUser(email, password);

            if (user != null) {
                session.setAttribute("user", user);
                if ("admin".equals(user.getRole())) {
                    response.sendRedirect("admin.jsp");
                } else {
                    response.sendRedirect("shopNow.jsp");
                }
            } else {
                session.setAttribute("login-failed", "Invalid email or password.");
                response.sendRedirect("register.jsp?showLogin=true");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            session.setAttribute("login-failed", "Database connection error: " + e.getMessage());
            response.sendRedirect("register.jsp?showLogin=true");
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
