package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.dao.UserDAO;
import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String securityQuestion = request.getParameter("securityQuestion");
        String securityAnswer = request.getParameter("securityAnswer");
        String newPassword = request.getParameter("newPassword");

        HttpSession session = request.getSession();
        
        try {
            Connection conn = DBConnect.getConn();
            UserDAO dao = new UserDAO(conn);
            boolean success = dao.resetPassword(email, securityQuestion, securityAnswer, newPassword);

            if (success) {
                session.setAttribute("msg", "Password reset successful. Please login with your new password.");
                response.sendRedirect("register.jsp?showLogin=true");
            } else {
                session.setAttribute("error-msg", "Failed to reset password. Please check your details and try again.");
                response.sendRedirect("forgotPassword.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            session.setAttribute("error-msg", "Database connection error. Please try again later.");
            response.sendRedirect("forgotPassword.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error-msg", "An unexpected error occurred. Please try again later.");
            response.sendRedirect("forgotPassword.jsp");
        }
    }
}
