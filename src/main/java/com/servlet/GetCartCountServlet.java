package com.servlet;

import com.dao.CartDAO;
import com.db.DBConnect;
import com.user.UserDetails;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/GetCartCountServlet")
public class GetCartCountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDetails user = (UserDetails) session.getAttribute("user");

        if (user != null) {
            Connection conn = null;
            try {
                conn = DBConnect.getConn();
                CartDAO cartDAO = new CartDAO(conn);
                int cartCount = cartDAO.getCartItemCount(user.getId());
                session.setAttribute("cartCount", cartCount);
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        } else {
            session.setAttribute("cartCount", 0);
        }
    }
}

