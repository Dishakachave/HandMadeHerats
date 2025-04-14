package com.servlet;

import com.dao.WishlistDAO;
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

@WebServlet("/GetWishlistCountServlet")
public class GetWishlistCountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDetails user = (UserDetails) session.getAttribute("user");

        if (user != null) {
            Connection conn = null;
            try {
                conn = DBConnect.getConn();
                WishlistDAO wishlistDAO = new WishlistDAO(conn);
                int wishlistCount = wishlistDAO.getWishlistItemCount(user.getId());
                session.setAttribute("wishlistCount", wishlistCount);
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
            session.setAttribute("wishlistCount", 0);
        }
    }
}
