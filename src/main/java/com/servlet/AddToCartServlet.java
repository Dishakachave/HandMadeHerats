package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.dao.CartDAO;
import com.db.DBConnect;
import com.user.UserDetails;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        HttpSession session = request.getSession();
        UserDetails user = (UserDetails) session.getAttribute("user");

        if (user != null) {
            int userId = user.getId();
            Connection conn = null;

            try {
                conn = DBConnect.getConn();
                CartDAO dao = new CartDAO(conn);
                boolean success = dao.addToCart(userId, productId, quantity);

                if (success) {
                    response.sendRedirect("cart.jsp");
                } else {
                    session.setAttribute("error", "Failed to add item to cart.");
                    response.sendRedirect("shopNow.jsp");
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                session.setAttribute("error", "Database connection error: " + e.getMessage());
                response.sendRedirect("shopNow.jsp");
            } finally {
                try {
                    if (conn != null && !conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            session.setAttribute("error", "You need to log in first.");
            response.sendRedirect("register.jsp?showLogin=true");
        }
    }
}
